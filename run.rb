require_relative 'processor'

words = File.read("dictionary.txt").strip.split

processor = Processor.new(words)

pairs = processor.create_list

File.open "sequence_list.txt", "w" do |csv|
  pairs.each do |sequence, original|
    csv.puts "#{sequence}   #{original}"
  end
end
