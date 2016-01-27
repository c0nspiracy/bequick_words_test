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

    words = ["trump", "hair"]
    pairs = { "trum" => "trump", "rump" => "trump", "hair" => "hair" }

    assert_equal pairs, pro.create_sequence_word_pairs(words)
  end

  def test_create_list
    words = []
    processor = Processor.new(words)
    expected = []
    assert_equal expected, processor.create_list

    words = %w(arrows carrots give me)
    processor = Processor.new(words)
    expected = [
      ["carr", "carrots"],
      ["give", "give"],
      ["rots", "carrots"],
      ["rows", "arrows"],
      ["rrot", "carrots"],
      ["rrow", "arrows"]
    ]
    assert_equal expected, processor.create_list
  end
end
