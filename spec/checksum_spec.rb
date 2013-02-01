require 'spec_helper'


describe BankOcr::Checksum do

  it %q{should return true for a valid account number 000000051} do
    BankOcr.valid_checksum?([0,0,0,0,0,0,0,5,1])[:result].should be_true
  end

  it %q{should return false for an invalid account number 457508001} do
    BankOcr.valid_checksum?([4,5,7,5,0,8,0,0,1])[:result].should be_false
  end
  
  it %q{should return illegible for an illegible account number 475080?1} do
    BankOcr.valid_checksum?([4,5,7,5,0,8,0,'?',1])[:illegible].should be_true
  end

  it %q{should output ERR for an invalid account number 457508001} do
    BankOcr.read('user_story_3.txt')
    file = File.open(File.expand_path(File.dirname(__FILE__) + "/../output/user_story_3_output.txt"))
    file.each { |line| line.include?('ERR').should be_true if line.include?('457508001') }
  end

  it %q{should output ILL for an invalid account number 4575080?1} do
    BankOcr.read('user_story_3.txt')
    file = File.open(File.expand_path(File.dirname(__FILE__) + "/../output/user_story_3_output.txt"))
    file.each { |line| line.include?('ILL').should be_true if line.include?('4575080?1') }
  end

  it %q{should not output ILL for an valid account number 000000051} do
    BankOcr.read('user_story_3.txt')
    file = File.open(File.expand_path(File.dirname(__FILE__) + "/../output/user_story_3_output.txt"))
    file.each { |line| line.include?('ILL').should be_false if line.include?('000000051') }
  end

  it %q{should not output ERR for an valid account number 000000051} do
    BankOcr.read('user_story_3.txt')
    file = File.open(File.expand_path(File.dirname(__FILE__) + "/../output/user_story_3_output.txt"))
    file.each { |line| line.include?('ERR').should be_false if line.include?('000000051') }
  end

end




































