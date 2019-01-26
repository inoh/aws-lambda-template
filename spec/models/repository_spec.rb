require 'spec_helper'

require './app/models/repository'

describe Repository do
  let(:repository) { described_class.new }

  describe '#create' do
    subject { repository.create(1, 'ino_h') }

    it 'レコードを作成すること' do
      is_expected.to eq(
        id: 1,
        name: 'ino_h'
      )
    end
  end
end
