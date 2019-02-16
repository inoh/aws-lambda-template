require 'json'
require 'app/models/serializer'
require 'app/models/repository'

def create(event:, context:)
  request = JSON.parse(event['body'])

  user = repository.find(
    request['id']
  )

  return { statusCode: 204 } unless user

  {
    statusCode: 200,
    body: {
      access_token: serializer.encode(
        id: user['id'],
        name: user['name']
      )
    }.to_json
  }
end

def show(event:, context:)
  token = event['headers']['Authorization'].split(' ').last

  {
    statusCode: 200,
    body: serializer.decode(token).to_json
  }
end

private

def serializer
  @serializer ||= Serializer.new
end

def repository
  @repository ||= Repository.new
end
