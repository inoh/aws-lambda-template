require 'json'
require 'app/models/serializer'

def create(event:, context:)
  serializer = Serializer.new

  request = JSON.parse(event['body'])

  {
    statusCode: 200,
    body: {
      access_token: serializer.encode(
        name: request['name']
      )
    }.to_json
  }
end

def show(event:, context:)
  serializer = Serializer.new

  token = event['headers']['Authorization'].split(' ').last

  {
    statusCode: 200,
    body: serializer.decode(token).to_json
  }
end
