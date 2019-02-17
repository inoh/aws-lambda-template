require 'spec_helper'

require './app/models/repository'

describe Repository do
  let(:repository) { described_class.new }

  describe '#save' do
    subject do
      repository.save(
        Repository::User.new('ino_h', 'inoue', 'secret')
      )
    end

    it { is_expected.to be(true) }
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
