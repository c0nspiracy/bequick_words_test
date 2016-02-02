require 'pry'

class Processor

  def initialize(input_filename, output_filename)
    @dictionary = get_words_from_file(input_filename)
    @output_filename = output_filename
    @pairs_hash = Hash.new { |pairs_hash, sequence| pairs_hash[sequence] = [] }
  end

  def create_list
    create_sequence_word_pairs
    unique_sequences = select_unique_sequences(@pairs_hash)
    alphabetize_pairs_by_sequence(unique_sequences)
  end

  def get_words_from_file(input_filename)
    File.read(input_filename).strip.split
  end

  def all_sequences(word)
    sequences = []
    while word.length > 3
      four_letter_sequence = word[0..3]
      sequences << four_letter_sequence
      word = word[1..-1]
    end
    sequences
  end

  def create_sequence_word_pairs
    @dictionary.each do |word|
      extracted_sequences = all_sequences(word)
      extracted_sequences.each { |sequence| @pairs_hash[sequence] << word }
    end
  end

  def select_unique_sequences(sequence_word_pairs)
    sequence_word_pairs.select do |sequence, duplicate_words_array|
      duplicate_words_array.length == 1
    end
  end

  def alphabetize_pairs_by_sequence(unique_sequences)
    unique_sequences.sort_by { |sequence, word| sequence.downcase }
  end

  # def output_to_file
  #   File.open @output_filename, "w" do |csv|
  #     @pairs_array.each do |pairing|
  #       sequence = pairing[0]
  #       original = pairing[1]
  #       output_line = formatter(sequence, original)
  #       csv.puts output_line
  #     end
  #   end
  # end
  #
  # def formatter(sequence, word)
  #   [quote_string(sequence), quote_string(word)].join '   '
  # end
  #
  # def quote_string(s)
  #   '' + s + ''
  # end

end
