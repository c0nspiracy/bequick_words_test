class Processor
  def initialize(input_filename, output_filename)
    @words = get_words_from_file(input_filename)
    @output_filename = output_filename
  end

  def create_list
    pairs = create_sequence_word_pairs(@words)
    pairs = alphabetize_pairs_by_sequence(pairs)
    output_to_file(pairs)
  end

  def get_words_from_file(input_filename)
    File.read(input_filename).strip.split
  end

  def create_sequence_word_pairs(words)
    words.each_with_object({}) { |word, memo|
      extract_sequences_from_word(word).each do |sequence|
        memo[sequence] = memo.key?(sequence) ? nil : word
      end
    }.reject { |_, v| v.nil? }
  end

  def extract_sequences_from_word(word)
    (0..(word.length - 4)).map { |n| word.slice(n, 4) }
  end

  def alphabetize_pairs_by_sequence(pairs)
    pairs.sort_by { |sequence, _| sequence.downcase  }
  end

  def output_to_file(pairs)
    File.open @output_filename, "w" do |csv|
      pairs.each do |sequence, original|
        csv.puts "#{sequence}   #{original}"
      end
    end
  end
end
