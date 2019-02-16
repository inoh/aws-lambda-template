require 'app/models/repository'

def create(event:, context:)
  request = JSON.parse(event['body'])

  user = Repository::User.new(
    request['id'],
    request['name'],
    request['password']
  )

  repository.create(user)

  {
    statusCode: 204
  }
end

private

def repository
  @repository ||= Repository.new
end
