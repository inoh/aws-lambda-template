require 'aws-sdk'

def create(event:, context:)
  dynamoDB = Aws::DynamoDB::Resource.new(region: 'us-west-2')

  {
    statusCode: 200,
    body: dynamoDB.tables.map(&:name).to_json
  }
end
