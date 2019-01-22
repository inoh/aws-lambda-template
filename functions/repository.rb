require 'aws-sdk'

class Repository
  def initialize
    @client = Aws::DynamoDB::Client.new
  end

  def create(id, name)
    item = {
      id: 'ino_h',
      name: 'inoue'
    }
  
    client.put_item(
      table_name: 'Users',
      item: item
    )

    item
  end

  private

  attr_reader :client
end
