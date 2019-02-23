require 'app/models/serializer'
require 'app/models/repository'

def create(event:, context:)
  request = JSON.parse(event['body'])

  user = repository.find(
    request['id']
  )

  return { statusCode: 401 } if user&.password != request['password']

  {
    statusCode: 200,
    body: {
      access_token: serializer.encode(
        id: user['id']
      )
    }.to_json
  }
end

def show(event:, context:)
  token = event['headers']['Authorization'].split(' ').last

  payload = serializer.decode(token)

  return { statusCode: 401 } if payload.nil?

  user = repository.find(
    payload['id']
  )

  return { statusCode: 404 } if user.nil?

  {
    statusCode: 200,
    body: {
      id: user.id,
      name: user.name
    }.to_json
  }
end

private

def serializer
  @serializer ||= Serializer.new
end

def repository
  @repository ||= Repository.new
end
