require 'aws-sdk-dynamodb'

class Repository
  def initialize
    @client = Aws::DynamoDB::Client.new
  end

  def create(id, name)
    item = {
      id: id,
      name: name
    }
  
    client.put_item(
      table_name: 'Users',
      item: item
    )

    item
  end

  def find(id)
    client.get_item(
      table_name: 'Users',
      key: {
        id: id
      }
    ).item
  rescue Aws::DynamoDB::Errors::ResourceNotFoundException => e
    nil
  end

  private

  attr_reader :client
end
