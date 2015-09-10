module Address
  module Io
    class State
      include ApiResource
      include ApiOperations::List
      def self.url
        "/v1/states"
      end

      def url
        "#{self.class.url}/#{self.id}"
      end
    end
  end
end