param (
    [Parameter(Mandatory=$true)][string]$shard = "3",
    [Parameter(Mandatory=$true)][string]$refresh_token,
    [Parameter(Mandatory=$true)][string]$account_num,
    [Parameter(Mandatory=$true)][string]$cat_name
)


#### Cloud Management Authentication
$api_end_point = "https://us-$shard.rightscale.com/api/oauth2"

$msgbody = @{
    grant_type="refresh_token"
    refresh_token=$refresh_token
}
$body = (ConvertTo-Json $msgbody)

$hdrs = @{}
$hdrs.Add("X-API-Version", "1.5")
$hdrs.Add("Content-Type", "application/json")

$response = Invoke-RestMethod -Uri $api_end_point -Method Post -Body $body -Headers $hdrs 
   
$access_token = $response.access_token

#### Self-Service Authentication
$api_end_point = "https://selfservice-$shard.rightscale.com/api/catalog/new_session?account_id=$account_num"
$hdrs = @{}
$hdrs.Add("Authorization", "Bearer $access_token")
$hdrs.Add("Content-Type", "application/json")

$response = Invoke-RestMethod -Uri $api_end_point -Method Get -Headers $hdrs 

#### Get CAT's Related HREF and Compilation HREF and FILENAME
$api_end_point = "https://selfservice-$shard.rightscale.com/api/designer/collections/$account_num/templates?filter[]=name==$cat_name"
$hdrs.Add("X-Api-Version", "1.0")

$response = Invoke-RestMethod -Uri $api_end_point -Method Get -Headers $hdrs

$cat_href = $response.href
$compilation_href = $response.compilation_href
$cat_filename = $response.filename

### Recompile the CAT in situ
### This queues the recompile job
$api_end_point = "https://selfservice-$shard.rightscale.com$compilation_href/actions/recompile"

$msgbody = @{
    infer_dependencies=$true
}
$body = (ConvertTo-Json $msgbody)

# Using Invoke-WebRequest because I need the href in the Location attribute in the header and I could not find a way to get headers from invoke-restmethod
$response = Invoke-WebRequest -Uri $api_end_point -Method Post -Body $body -Headers $hdrs

# Get the new compilation_href for the newly compiled file
$compilation_href = $response.Headers.Location

### Check recompile job status
$api_end_point = "https://selfservice-$shard.rightscale.com$compilation_href"

Do {
    $response = Invoke-RestMethod -Uri $api_end_point -Method Get -Headers $hdrs
    $job_status = $response.status
    Write-Host "Recompile Job Status: $job_status"
} Until ($job_status -eq "successful")

$compilation_href = $response.compilation_result.compilation_href

### Now update with the newly compiled version and set the filename accordingly
$api_end_point = "https://selfservice-$shard.rightscale.com$cat_href/actions/update_from_compilation"

$msgbody = @{
    compilation_href=$compilation_href
    filename=$cat_filename
}
$body = (ConvertTo-Json $msgbody)
    
$response = Invoke-RestMethod -Uri $api_end_point -Method Post -Body $body -Headers $hdrs 
    