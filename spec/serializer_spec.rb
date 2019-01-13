require 'spec_helper'

require './functions/serializer'

describe Serializer do
  let(:serializer) { described_class.new }

  describe '#encode' do
    subject { serializer.encode(name: 'ino_h') }

    it { is_expected.to eq('eyJhbGciOiJub25lIn0.eyJuYW1lIjoiaW5vX2gifQ.') }
  end

  describe '#decode' do
    subject { serializer.decode('eyJhbGciOiJub25lIn0.eyJuYW1lIjoiaW5vX2gifQ.') }

    it { is_expected.to match(name: 'ino_h') }
  end
end
