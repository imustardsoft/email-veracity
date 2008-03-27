module EmailVeracity
  
  
  class Address
    
    include Validity
    
    attr_reader :domain
    
    def initialize(email = '')
      self.email_address = email
    end
    
    def to_s
      email_address
    end
    
    def email_address
      @email_address.to_s.strip
    end
    
    def email_address=(new_email_address)
      @email_address = new_email_address
      @domain = Domain.new(@email_address.split('@')[1] || '')
    end
    
    def validate!
      add_error << :malformed if !pattern_valid?
      return if Config.options[:check_pattern_only]
      add_errors domain.errors
    end
    
    protected
      def pattern_valid?
        @email_address =~ Config.options[:valid_address_pattern]
      end
      
  end
  
  
end