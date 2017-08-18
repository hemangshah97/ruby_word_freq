#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer

  attr_accessor :content,:highest_wf_count,:highest_wf_words,:line_number

  def initialize(line,number)
    @highest_wf_words=Array.new(0)
    @content=line
    @line_number=number
    @highest_wf_count=0
    calculate_word_frequency()
  end


  def calculate_word_frequency()
    word_frequency = Hash.new {0}
    @content.split(' ').each do |word|
      word_frequency[word.downcase]+=1
    end
    temp=[]
    word_frequency.each {|k,v| temp<<v}
    @highest_wf_count=temp.max
    word_frequency.each_pair do |k,v|
      self.highest_wf_words.push(k) if v==highest_wf_count
    end 
  end

end

#  Implement a class called Solution. 
class Solution


  attr_reader :highest_count_across_lines,:highest_count_words_across_lines,:analyzers

  def initialize
    @analyzers=Array.new(0)
  end

  def analyze_file
    number=1
    File.foreach('test.txt') do |line|
      lineread = LineAnalyzer.new(line,number)
      self.analyzers.push(lineread)
      number+=1
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_across_lines = analyzers.sort_by { |analyzer| analyzer.highest_wf_count }.reverse.first.highest_wf_count
    @highest_count_words_across_lines = analyzers.select { |analyzer| @highest_count_across_lines == analyzer.highest_wf_count }
  end

  def print_highest_word_frequency_across_lines
    puts "The following have the highest word frequency per line:"

    @highest_count_words_across_lines.each do |word|
      p "#{word.highest_wf_words}(appears in line #{word.line_number})"
    end
  end
end