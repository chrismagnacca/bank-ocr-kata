module BankOcr

  require File.expand_path(File.dirname(__FILE__) + "/bank_ocr/parser")
  require File.expand_path(File.dirname(__FILE__) + "/bank_ocr/checksum")
  require File.expand_path(File.dirname(__FILE__) + "/bank_ocr/program")

  extend Program
end
