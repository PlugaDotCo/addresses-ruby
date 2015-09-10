module Address
  module Io
    class City
      include ApiResource
      def self.url
        "/v1/states/#{@state}/cities"
      end

      def url
        "#{self.class.url}/#{self.id}"
      end

      def self.list_all(params=nil)
        if params && params[:state]
          @state = params[:state]
          api_request(url, :get, params)
        else
          nil
        end
      end
    end
  end
end