module BankOcr
  module Program
    require File.expand_path(File.dirname(__FILE__) + "/parser")
    
    def parser
      @parser ||= Parser.new
    end
    
    def method_missing(method, *args, &block)
      return self.parser.send(method) if args.empty?
      return self.parser.send(method, args.first) if args.length == 1
      self.parser.send(method, args)
    end
    
    def respond_to?(method)
      return true if (self.methods.include?(method) || self.instance_methods.include?(method))
      false
    end
    
  end
end