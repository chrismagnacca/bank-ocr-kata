require File.expand_path(File.dirname(__FILE__) + "/lib/bank_ocr.rb")

ARGV.each do |arg|
  BankOcr.read(arg)
end

