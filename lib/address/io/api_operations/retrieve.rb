module Address
  module Io
    module ApiOperations
      module Retrieve
        def retrieve(postal_code=nil)
          return nil unless postal_code
          postal_code = "?postal_code=#{postal_code}" if postal_code.include? '@'
          api_request("#{url}/#{postal_code}", :get)
        end

        def self.included(base)
          base.extend(Retrieve)
        end
      end
    end
  end
end