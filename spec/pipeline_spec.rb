require 'pipeline'
require 'pry'

RSpec.describe Pipeline do
  let(:file) { File.new('spec/fixtures/sample.txt') }

  describe '#process' do
    subject(:output) { pipeline.process }
    let(:pipeline) { described_class.new(file, chunk_size) }

    context 'when reading chunks of 27 bytes' do
      let(:chunk_size) { 27 } # bytes

      it 'returns the content of the file' do
        expect(output).to eq(File.read('spec/fixtures/sample.txt'))
      end
    end

    context 'when reading chunks of 32 bytes' do
      let(:chunk_size) { 32 } # bytes

      it 'returns the content of the file' do
        expect(output).to eq(File.read('spec/fixtures/sample.txt'))
      end
    end
  end
end
