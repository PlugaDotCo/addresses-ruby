module Address
  module Io
    module ApiOperations
      module List
        include ApiResource

        def list_all(params=nil)
          api_request(url, :get, params)
        end

        def self.included(base)
          base.extend(List)
        end
      end
    end
  end
end