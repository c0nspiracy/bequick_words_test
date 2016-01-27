class Processor
  def initialize(input_filename, output_filename)
    @dictionary = get_words_from_file(input_filename)
    @output_filename = output_filename
    @sequences = []
    @pairs_array = []
  end

  def create_list
    @pairs_array = create_sequence_word_pairs(@dictionary)
    @pairs_array = remove_unwanted_duplicates(@pairs_array)
    @pairs_array = alphabetize_pairs_by_sequence(@pairs_array)
    output_to_file
  end

  def get_words_from_file(input_filename)
    File.read(input_filename).strip.split
  end

  def create_sequence_word_pairs(dictionary)
    dictionary.flat_map do |word|
      extracted_sequences = extract_sequences_from_word(word)
      extracted_sequences.map do |sequence|
        [sequence, word]
      end
    end
  end

  def extract_sequences_from_word(word)
    sequences = []

    while word.length > 3
      four_letter_sequence = word[0..3]

      sequences << four_letter_sequence

      word = word[1..-1]
    end

    sequences
  end

  def remove_unwanted_duplicates(pairs)
    sequences = pairs.map { |pair| pair.first }
    duplicate_sequences = identify_duplicate_sequences(sequences)
    pairs.reject do |sequence, original|
      duplicate_sequences.include? sequence
    end
  end

  def identify_duplicate_sequences(sequences)
    sequence_count = sequences.each_with_object(Hash.new(0)) { |sequence, memo|
      memo[sequence] += 1
    }
    sequences.select { |sequence| sequence_count[sequence] > 1 }.uniq
  end

  def alphabetize_pairs_by_sequence(pairs)
    pairs.sort_by { |sequence, original| sequence.downcase  }
  end

  def output_to_file
    File.open @output_filename, "w" do |csv|
      @pairs_array.each do |pairing|
        sequence, original = pairing
        output_line = formatter sequence, original
        csv.puts output_line
      end
    end
  end

  def formatter(sequence, word)
    [quote_string(sequence), quote_string(word)].join '   '
  end

  def quote_string(s)
    '' + s + ''
  end
end
