require File.expand_path(File.dirname(__FILE__) + "/checksum")

module BankOcr
  class Parser
    include Checksum

    attr_accessor :encoding, :encoded_account_numbers, :decoded_account_numbers
    
    def initialize
      self.encoded_account_numbers = []
      self.decoded_account_numbers = []
      self.encoding = {
        0 => [' _ ','| |','|_|'],
        1 => ['   ','  |','  |'],
        2 => [' _ ',' _|','|_ '],
        3 => [' _ ',' _|',' _|'],
        4 => ['   ','|_|','  |'],
        5 => [' _ ','|_ ',' _|'],
        6 => [' _ ','|_ ','|_|'],
        7 => [' _ ','  |','  |'],
        8 => [' _ ','|_|','|_|'],
        9 => [' _ ','|_|',' _|'],
      }
    end
    
    def read(file_name)
      file = File.open(File.expand_path(File.dirname(__FILE__) + "/../../user_stories/" + file_name))
      self.encoded_account_numbers = file.lines.each_slice(4).take(4) # utilize IO lines enumerator to slice file
      file.close
      
      self.encoded_account_numbers.each do |encoded_number|
        lines = []
        
        encoded_number.each do |line|
         split = line.scan(/.../)
         lines << split if not split.empty?
        end
        
        self.decoded_account_numbers << decode_number(lines[0],lines[1],lines[2])
      end
      
      output_file = File.open(File.expand_path(File.dirname(__FILE__) + "/../../output/" + file_name.gsub(/.txt$/,'') + "_output.txt"), 'w+')
      
      self.decoded_account_numbers.each do |decoded_account_number|
        checksum = valid_checksum?(decoded_account_number)
        
        formatted_number = decoded_account_number.collect{ |item| item.to_s }.join
        formatted_number = (formatted_number + " ERR") if not (checksum[:result] || checksum[:illegible])
        formatted_number = (formatted_number + " ILL") if formatted_number.include?('?')

        output_file.puts formatted_number
      end
      
      output_file.close
      
      return self
    end
    
    def decode_number(line0, line1, line2)
      decoded_number = []
      (0..8).each { |n| decoded_number.push(decode_digit([line0[n],line1[n],line2[n]])) }
      decoded_number
    end
    
    def decode_digit(encoded_digit)
      self.encoding.key(encoded_digit) || '?'
    end 
    
    def pretty_print(encoded_digit)
      encoded_digit.each{ |line| puts line }
    end

  end
end