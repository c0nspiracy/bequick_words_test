class Processor
  def initialize(words = [])
    @words = words
  end

  def create_list
    pairs = create_sequence_word_pairs(@words)
    alphabetize_pairs_by_sequence(pairs)
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
end
