require 'spec_helper'


describe BankOcr::Parser do
  
  before(:each) do
    @bank_ocr = BankOcr.read('user_story_1.txt')
  end
  
  describe 'BankOcr::Parser.read(file_name)' do
  
    it %q{should populate an array of encoded numbers for BankOcr::Parser.read(file_name)} do
      @bank_ocr.encoded_account_numbers.should_not be_nil
      @bank_ocr.encoded_account_numbers.should_not be_empty
    end
    
    it %q{should populate an array of decoded numbers for BankOcr::Parser.read(file_name)} do
      @bank_ocr.decoded_account_numbers.should_not be_nil
      @bank_ocr.decoded_account_numbers.should_not be_nil
    end
  
  end
  
  describe 'BankOcr::Parser.decode_number(three_element_account_number_line_array)' do
    before(:each) do
      valid_account_lines  = ["    _  _     _  _  _  _  _ ",
                              "  | _| _||_||_ |_   ||_||_|",
                              "  ||_  _|  | _||_|  ||_| _|"]
      invalid_account_lines  = ["    _  _     _  _  _  _  _ ",
                                "  | _| _||_||_ |_   |||||_|",
                                "  ||_  _|  | _||_|  |||| _|"]
                
      @valid_lines = []
      @invalid_lines = []
      @bank_ocr_parser = BankOcr::Parser.new
      valid_account_lines.each { |valid_account_line| @valid_lines.push(valid_account_line.scan(/.../)) }
      invalid_account_lines.each { |invalid_account_line| @invalid_lines.push(invalid_account_line.scan(/.../)) }
    end
    
    it %q{should return [1,2,3,4,5,6,7,8,9] for BankOcr::Parser.decode_number(account_with_legible_digits)} do
      @bank_ocr_parser.decode_number(@valid_lines[0],@valid_lines[1],@valid_lines[2]).should eq([1,2,3,4,5,6,7,8,9])
    end
    
    it %q{should return [1,2,3,4,5,6,7,?,9] forBankOcr::Parser.decode_number(account_with_illegible_digit)} do
      @bank_ocr_parser.decode_number(@invalid_lines[0],@invalid_lines[1],@invalid_lines[2]).should eq([1,2,3,4,5,6,7,'?',9])
    end
    
  end
  
  describe 'BankOcr::Parser.decode_digit(three_element_stick_digit_array)' do
  
    it %q{should return 0 for BankOcr::Parser.decode_digit([' _ ','| |','|_|'])} do
      @bank_ocr.decode_digit([' _ ','| |','|_|']).should eq(0)
    end

    it %q{should return 1 for BankOcr::Parser.decode_digit(['   ','  |','  |'])} do
      @bank_ocr.decode_digit(['   ','  |','  |']).should eq(1)
    end
  
    it %q{should return 2 for BankOcr::Parser.decode_digit([' _ ',' _|','|_ '])} do
      @bank_ocr.decode_digit([' _ ',' _|','|_ ']).should eq(2)
    end
  
    it %q{should return 3 for BankOcr::Parser.decode_digit([' _ ',' _|',' _|'])} do
      @bank_ocr.decode_digit([' _ ',' _|',' _|']).should eq(3)
    end
  
    it %q{should return 4 for BankOcr::Parser.decode_digit(['   ','|_|','  |'])} do
      @bank_ocr.decode_digit(['   ','|_|','  |']).should eq(4)
    end
  
    it %q{should return 5 for BankOcr::Parser.decode_digit([' _ ','|_ ',' _|'])} do
      @bank_ocr.decode_digit([' _ ','|_ ',' _|']).should eq(5)
    end
  
    it %q{should return 6 for BankOcr::Parser.decode_digit([' _ ','|_ ','|_|'])} do
      @bank_ocr.decode_digit([' _ ','|_ ','|_|']).should eq(6)
    end
 
    it %q{should return 7 for BankOcr::Parser.decode_digit([' _ ','  |','  |'])} do
      @bank_ocr.decode_digit([' _ ','  |','  |']).should eq(7)
    end
  
    it %q{should return 8 for BankOcr::Parser.decode_digit([' _ ','|_|','|_|'])} do
      @bank_ocr.decode_digit([' _ ','|_|','|_|']).should eq(8)
    end
  
    it %q{should return 9 for BankOcr::Parser.decode_digit([' _ ','|_|',' _|'])} do
      @bank_ocr.decode_digit([' _ ','|_|',' _|']).should eq(9)
    end
    
    it %q{should return ? for BankOcr::Parser.decode_digit(['_','|_|','_|'])} do
      @bank_ocr.decode_digit(['_','|_|','_|']).should eq('?')
    end  
    
  end
  
  describe 'BankOcr::Parser.pretty_print(three_element_stick_digit_array)' do
    it %q{should allow pretty printing of a number} do
      lambda { BankOcr::Parser.new.pretty_print([' _ ','| |','|_|']) }.should_not raise_exception
    end
  end
  
end
