require 'test/unit'
require_relative 'processor'

class TestProcessor < Test::Unit::TestCase
  def test_extract_sequences_from_word
    pro = Processor.new("dictionary.txt", "sequence_list.txt")
    short_seqs = pro.extract_sequences_from_word "abc"
    assert_equal [], short_seqs

    seqs = pro.extract_sequences_from_word "hello"

    assert_equal "hell", seqs.first
    assert_equal "ello", seqs.last
  end

  def test_get_words_from_file
    pro = Processor.new("dictionary.txt", "sequence_list.txt")
    words = pro.get_words_from_file "dictionary.txt"

    assert_instance_of Array, words
    assert_equal words, words.grep(String)
    assert_equal 25_143, words.count
    assert_no_match(/\s/, words.join)
    assert_nil words.detect{ |w| w.length == 0 }
  end

  # def test_identify_duplicate_sequences
  #   pro = Processor.new("dictionary.txt", "sequence_list.txt")
  #   list = ['word', 'word', 'word', 'help']
  #
  #   duplicates = pro.identify_duplicate_sequences list
  #   assert_equal ['word'], duplicates
  #
  #   list2 = ['aaaa', 'bbbb', 'cccc']
  #   duplicates2 = pro.identify_duplicate_sequences list2
  #   assert_equal [], duplicates2
  # end

  # def test_create_sequence_word_pairs
  #   pro = Processor.new("dictionary.txt", "sequence_list.txt")
  #
  #   assert_equal [], pro.create_sequence_word_pairs([])
  #
  #   pair = ["trump", "hair"]
  #   pair2 = [["trum", "trump"], ["rump", "trump"], ["hair", "hair"]]
  #
  #   assert_equal pair2, pro.create_sequence_word_pairs(pair)
  # end
  #
  # def test_create_list
  #   pro = Processor.new("dictionary.txt", "sequence_list.txt")
  #
  #   assert_equal [], pro.create_list([])
  #
  #   pairs = [["carr", "carrots"], ["arro", "arrows"], ["arro", "carrots"], ["give", "give"]]
  #   sanitized_pair = [["carr", "carrots"], ["give", "give"]]
  #   assert_equal sanitized_pair, pro.create_list(pairs)
  # end

end
