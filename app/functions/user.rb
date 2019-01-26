require 'app/models/repository'

def create(event:, context:)
  repository = Repository.new

  request = JSON.parse(event['body'])

  user = repository.create(
    request['id'],
    request['name']
  )

  {
    statusCode: 200,
    body: user.to_json
  }
end
