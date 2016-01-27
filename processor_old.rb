class Processor
	# Omit strings less than 4 characters and extract the 4-letter
	# sequences from the other strings.
    def extract_sequences_from_original_word original_word
        return [] if original_word.length < 4
        sequences = []
		
        while original_word.length > 3
            four_letter_seq = original_word[0..3]
            sequences << four_letter_seq

            original_word = original_word[1..-1]
        end

        return sequences
    end
	
    def load_dictionary input_filename
      File.read(input_filename).strip.split
    end
	
	# Find multiples within the 4-letter sequence list.
    def identify_duplicate_sequences sequences
        sequences.select { |e| sequences.count(e) > 1 }.uniq
    end

	# Removing all instances of duplicates.
    def remove_unwanted_duplicates word_pairs
        all_sequences = word_pairs.map{ |pair| pair.first }

        duplicate_seqs = identify_duplicate_sequences all_sequences

        word_pairs.reject do |seq, original|
          duplicate_seqs.include? seq
        end
    end

    def alphabetize_pairs_by_seq pair_list
      pair_list.sort_by{ |seq, original|  seq.downcase  }
    end
	
    # Pairing up every 4-letter sequence with the word it
    # was derived from.
    def create_sequence_word_pairs dict_words
        pairs_array = []

        dict_words.each do |original|
            derived_seqs = extract_sequences_from_original_word original

            derived_seqs.each do |seq|
            pair = [seq, original]
            pairs_array << pair
            end
        end

        pairs_array
    end
	
	# Sorting the list and removing duplicates.
	def sanitize_pair_list pairs_array
		without_duplicates = remove_unwanted_duplicates pairs_array
		alphabetize_pairs_by_seq(without_duplicates)
	end
	
	# Creating the final 2-column list.
    def list_creator dict_filename, output_filename
        originals = load_dictionary dict_filename

        pairings = create_sequence_word_pairs originals
        pairings = sanitize_pair_list pairings

        File.open output_filename, "w" do |csv|

            pairings.each do |pairing|
                seq = pairing[0]
                original = pairing[1]

                output_line = formatter seq, original

                csv.puts output_line
            end
        end
    end

    def formatter seq, word
        [quote_string(seq), quote_string(word)].join '     '
    end

    def quote_string s
        '' + s + ''
    end
end