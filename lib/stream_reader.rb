class StreamReader
  def initialize(file, chunk_size)
    @file = file
    @chunk_size = chunk_size
  end

  def call(*)
    Enumerator.new do |yielder|
      while (chunk = @file.read(@chunk_size))
        yielder << chunk
      end
    end
  end
end
