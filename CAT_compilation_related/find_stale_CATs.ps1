param (
    [Parameter(Mandatory=$true)][string]$shard = "3",
    [Parameter(Mandatory=$true)][string]$refresh_token,
    [Parameter(Mandatory=$true)][string]$account_num
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

#### Get Stale CATs (i.e. ones that need to be recompiled)
$api_end_point = "https://selfservice-$shard.rightscale.com/api/designer/collections/$account_num/templates"
$hdrs.Add("X-Api-Version", "1.0")

$response = Invoke-RestMethod -Uri $api_end_point -Method Get -Headers $hdrs

foreach ($resp in $response) {
    if ($resp.stale -eq "true") {
        $cat_href = $resp.href
        $compilation_href = $resp.compilation_href
        $cat_name = $resp.name
        Write-Host "Stale CAT: $cat_name"
        
    }
 }