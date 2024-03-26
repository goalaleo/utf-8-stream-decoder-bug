class UTF8StreamDecoder
  def initialize
    @buffer = nil
  end

  def call(enumerable)
    Enumerator.new do |yielder|
      enumerable.each do |chunk|
        yielder << convert(chunk)
      end

      yielder << finish
    end
  end

  def convert(data)
    data = @buffer + data.force_encoding(Encoding::ASCII_8BIT) if @buffer
    data = data.force_encoding(Encoding::UTF_8)
    @buffer = nil

    if data.valid_encoding?
      data
    else
      data, @buffer = split_broken(data)
      data.scrub
    end
  end

  def finish
    @buffer ? @buffer.force_encoding(Encoding::UTF_8).scrub : ""
  ensure
    @buffer = nil
  end

  private

  # Split potentially incomplete UTF-8 characters. Stop when first
  # ascii-character or initial byte is found.
  def split_broken(input, broken = '')
    if input.empty? || ascii?(input.byteslice(-1..-1)) || initial_byte?(broken)
      [
        input,
        broken.force_encoding(Encoding::ASCII_8BIT)
      ]
    else
      split_broken(input.byteslice(0...-1), input.byteslice(-1..-1) + broken)
    end
  end

  def ascii?(character)
    character.bytes[0] < 0x80
  end

  def initial_byte?(character)
    !character.empty? && character.bytes[0] > 0xB7
  end
end
