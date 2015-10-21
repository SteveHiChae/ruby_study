class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize (content, line_number) 
    @content = content  
    @line_number = line_number
    @highest_wf_words = []
    @highest_wf_count = highest_wf_count
    calculate_word_frequency() 
  end

  def calculate_word_frequency()
    words = Hash.new(0)
    @content.split.each do |word|
      words[word.downcase] += 1
    end
    words = words.sort_by { |k,v| -v }
    @highest_wf_words << words[0][0]
    @highest_wf_count = words[0][1]

    if words.length > 1
      for i in 1..words.length-1 do
        if @highest_wf_count == words[i][1]
          @highest_wf_words << words[i][0]
        else
          break
        end
      end
    end
  end
end


class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize() 
    @analyzers = []
  end

  def analyze_file()
    File.foreach( 'test.txt' ).with_index do |line, line_num|   
      @analyzers << LineAnalyzer.new(line, line_num+1) 
    end
  end

  def calculate_line_with_highest_frequency()  
    @highest_count_across_lines = 0 
    @highest_count_words_across_lines = []
    @analyzers.each do |line|
      if line.highest_wf_count >= @highest_count_across_lines
        @highest_count_across_lines = line.highest_wf_count
        @highest_count_words_across_lines << line
      end
    end
  end

  def print_highest_word_frequency_across_lines() 
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |line|
      puts "#{line.highest_wf_words} (appears in line #{line.line_number})"    
    end
  end
end
