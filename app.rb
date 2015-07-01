require 'sinatra'
require 'httparty'
require 'uri'

helpers do
  def github_authorize_url
    "https://github.com/login/oauth/authorize?" + URI.encode_www_form(request_params)
  end

  def github_token_url
    "https://github.com/login/oauth/access_token"
  end

  def request_params
    params.merge(client_id: ENV['OAUTH_CLIENT_ID'])
  end

  def set_auth_message
    data = {
      client_id: ENV['OAUTH_CLIENT_ID'],
      client_secret: ENV['OAUTH_CLIENT_SECRET'],
      code: params[:code]
    }

    HTTParty.post github_token_url, data
  end
end

get '/authorize' do
  redirect github_authorize_url
end

get '/' do
  @message = set_auth_message.body
  erb :index
end
