require 'aws-sdk-dynamodb'

class Repository
  User = Struct.new(:id, :name, :password)

  def initialize
    @client = Aws::DynamoDB::Client.new
  end

  def create(user)
    client.put_item(
      table_name: 'Users',
      item: {
        id: user.id,
        name: user.name,
        password: user.password
      }
    )
  end

  def find(id)
    item = client.get_item(
      table_name: 'Users',
      key: {
        id: id
      }
    ).item

    User.new(
      item['id'],
      item['name'],
      item['password']
    )
  rescue Aws::DynamoDB::Errors::ResourceNotFoundException => e
    nil
  end

  private

  attr_reader :client
end
