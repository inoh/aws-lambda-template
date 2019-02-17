require 'spec_helper'

require './app/models/serializer'

describe Serializer do
  let(:serializer) { described_class.new }

  describe '#encode' do
    subject { serializer.encode(id: 'ino_h') }

    it 'jwt を作成すること' do
      is_expected.to eq(
        JWT.encode(
          { id: 'ino_h' },
          serializer.send(:rsa_private),
          'RS256'
        )
      )
    end
  end

  describe '#decode' do
    subject { serializer.decode(jwt) }

    let(:jwt) do
      JWT.encode(
        { id: 'ino_h' },
        serializer.send(:rsa_private),
        'RS256'
      )
    end

    it 'jwt のペイロードを返却すること' do
      is_expected.to eq('id' => 'ino_h')
    end

    context 'jwt が改ざんされている場合' do
      let(:jwt) do
        header, _payload, signature = super().split('.')

        [header, 'invalid', signature].join('.')
      end

      it { is_expected.to be_nil }
    end
  end
end
