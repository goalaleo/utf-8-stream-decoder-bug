require 'piperator'
require 'stream_reader'
require 'utf8_stream_decoder'

class Pipeline
  attr_reader :file, :chunk_size
  def initialize(file, chunk_size)
    @file = file
    @chunk_size = chunk_size
  end

  def process
    Piperator.build do
      pipe(StreamReader.new(file, chunk_size))
      pipe(UTF8StreamDecoder.new)
    end.call.reduce("") do |output, chunk|
      output << chunk
    end
  end
end
