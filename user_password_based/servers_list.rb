require 'rubygems'
require 'pp'                          # Pretty print Ruby gem
require 'right_api_client'            # RightScale API Client gem
                                      # Create client object. Effectively authenticate to use the RS API.
@client = RightApi::Client.new(:email => 'EMAIL', :password => 'PASSWORD', :account_id => '30601')
servers=@client.servers.index
pp @client.last_request[:response]
