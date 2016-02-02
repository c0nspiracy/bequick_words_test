require 'pry'

class Processor

  def initialize(input_filename, output_filename)
    @dictionary = get_words_from_file(input_filename)
    @output_filename = output_filename
    @sequences = []
    @pairs_array = []
    @pairs_hash = {}
  end

  def create_list
    create_sequence_word_pairs
    # remove_unwanted_duplicates
    # alphabetize_pairs_by_sequence
    # output_to_file
  end

  def get_words_from_file(input_filename)
    File.read(input_filename).strip.split
  end

  def all_sequences(word)
    @sequences = []
    while word.length > 3
      four_letter_sequence = word[0..3]
      @sequences << four_letter_sequence
      word = word[1..-1]
    end
    return @sequences
  end

  def create_sequence_word_pairs
    pairs_hash = Hash.new { |pairs_hash, sequence| pairs_hash[sequence] = [] }
    @dictionary.each do |word|
      extracted_sequences = all_sequences(word)
      extracted_sequences.each { |sequence| pairs_hash[sequence] << word }
    end
    puts pairs_hash
  end

  # def output_to_file
  #   File.open @output_filename, "w" do |csv|
  #     @pairs_array.each do |pairing|
  #       sequence = pairing[0]
  #       original = pairing[1]
  #       output_line = formatter sequence, original
  #       csv.puts output_line
  #     end
  #   end
  # end

  def identify_duplicate_sequences
    @sequences.select { |e| @sequences.count(e) > 1 }.uniq
  end

  def remove_unwanted_duplicates
    @pairs_array.map{ |pair| pair.first }
    duplicate_sequences = identify_duplicate_sequences
    @pairs_array.reject! do |sequence, original|
      duplicate_sequences.include? sequence
    end
  end

  # def identify_duplicate_sequences
  #   @sequences.select { |e| @sequences.count(e) > 1 }.uniq
  # end
  #
  # def remove_unwanted_duplicates
  #   @pairs_array.map{ |pair| pair.first }
  #   duplicate_sequences = identify_duplicate_sequences
  #   @pairs_array.reject! do |sequence, original|
  #     duplicate_sequences.include? sequence
  #   end
  # end
  #
  # def alphabetize_pairs_by_sequence
  #   @pairs_array.sort_by!{ |sequence, original| sequence.downcase  }
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
