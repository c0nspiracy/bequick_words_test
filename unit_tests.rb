require "test/unit"
require_relative "processor"

class TestProcessor < Test::Unit::TestCase
  def test_extract_sequences_from_word
    pro = Processor.new
    short_seqs = pro.extract_sequences_from_word "abc"
    assert_equal [], short_seqs

    seqs = pro.extract_sequences_from_word "hello"

    assert_equal "hell", seqs.first
    assert_equal "ello", seqs.last
  end

  def test_create_sequence_word_pairs
    pro = Processor.new

    assert_equal({}, pro.create_sequence_word_pairs([]))

    pair = ["trump", "hair"]
    pair2 = { "trum" => "trump", "rump" => "trump", "hair" => "hair" }

    assert_equal pair2, pro.create_sequence_word_pairs(pair)
  end

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
