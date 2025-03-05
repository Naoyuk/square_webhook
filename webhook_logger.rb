require 'sinatra'
require 'json'
require 'logger'

log_file = File.expand_path('webhook.log', __dir__)
logger = Logger.new(log_file)

get '/' do
  'Hello, World!'
end

post '/squire/webhook' do
  begin
    request_body = request.body.read
    logger.info("Received webhook at #{Time.now}")
    logger.info("Request body: #{request_body}")

    payload = JSON.parse(request_body)

    logger.info("Event type: #{payload['type']}")

    status 200
    "OK"

  rescue => e
    logger.error("Failed to process webhook: #{e.message}")
    status 500
    "Error"
  end
end
