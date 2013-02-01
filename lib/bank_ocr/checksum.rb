module BankOcr
  module Checksum
    
    def valid_checksum?(account_number)
      begin
        d9,d8,d7 = account_number[0],account_number[1],account_number[2]
        d6,d5,d4 = account_number[3],account_number[4],account_number[5]
        d3,d2,d1 = account_number[6],account_number[7],account_number[8]
        
        { :result => ((d1+(2*d2)+(3*d3)+(4*d4)+(5*d5)+(6*d6)+(7*d7)+(8*d8)+(9*d9))% 11 == 0) }
      rescue Exception => ex
        # provide handeling for account numbers with illegible digits
         { :illegible => true, :result => nil } if account_number.include?('?')
      end
    end
    
  end
end