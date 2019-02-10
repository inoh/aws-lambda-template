require 'spec_helper'

require './app/models/repository'

describe Repository do
  let(:repository) { described_class.new }

  describe '#create' do
    subject { repository.create('ino_h', 'inoue') }

    it 'レコードを作成すること' do
      is_expected.to eq(
        id: 'ino_h',
        name: 'inoue'
      )
    end
  end

  describe '#find' do
    subject { repository.find('ino_h') }

    pending 'DynamoDBをどう mock or stub にするか' do
      it 'レコードを取得すること' do
        is_expected.to have_attributes(
          id: 'ino_h',
          name: 'inoue'
        )
      end
    end
  end
end
