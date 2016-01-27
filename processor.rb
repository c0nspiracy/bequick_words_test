class Processor
  def initialize(input_filename, output_filename)
    @dictionary = get_words_from_file(input_filename)
    @output_filename = output_filename
    @sequences = []
    @pairs_array = []
  end

  def create_list
    pairs = create_sequence_word_pairs(@dictionary)
    pairs = remove_unwanted_duplicates(pairs)
    @pairs_array = alphabetize_pairs_by_sequence(pairs)
    output_to_file
  end

  def get_words_from_file(input_filename)
    File.read(input_filename).strip.split
  end

  def create_sequence_word_pairs(dictionary)
    hash = Hash.new { |hash, key| hash[key] = [] }
    dictionary.each_with_object(hash) { |word, memo|
      extract_sequences_from_word(word).each do |sequence|
        memo[sequence] << word
      end
    }
  end

  def extract_sequences_from_word(word)
    (0..(word.length - 4)).map { |n| word.slice(n, 4) }
  end

  def remove_unwanted_duplicates(pairs)
    pairs.reject { |k, v| v.count > 1 }
  end

  def alphabetize_pairs_by_sequence(pairs)
    pairs.sort_by { |sequence, original| sequence.downcase  }
  end

  def output_to_file
    File.open @output_filename, "w" do |csv|
      @pairs_array.each do |pairing|
        sequence, original = pairing.flatten
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
