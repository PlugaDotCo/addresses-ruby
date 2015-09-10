module Address
  module Io
    module ApiResource
      BASE_URL = 'http://open.nfe.io'

      def url_encode(key)
        URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      end

      def encode(params)
        params.map { |k,v| "#{k}=#{url_encode(v)}" }.join('&')
      end

      def api_request(url, method, params=nil)
        url = "#{BASE_URL}#{url}"
        api_key = Address::Io.access_keys

        if method == :get && params
          params_encoded = encode(params)
          url = "#{url}?#{params_encoded}"
          params = nil
        end

        begin
          payload = params.to_json
          response = RestClient::Request.new(method: method, url: url, payload: payload,
                                             headers: {authorization: api_key,
                                                       content_type: 'application/json',
                                                       accept: '*/*'}).execute
        rescue RestClient::ExceptionWithResponse => e
          return e.http_body
        rescue RestClient::Exception => e
          raise e
        end
        response = JSON.parse(response.to_str)
        recursive_symbolize_keys response
      end

      def recursive_symbolize_keys(h)
        case h
          when Hash
            Hash[
              h.map do |k, v|
                [ k.respond_to?(:to_sym) ? k.to_sym : k, recursive_symbolize_keys(v) ]
              end
            ]
          when Enumerable
            h.map { |v| recursive_symbolize_keys(v) }
          else
            h
        end
      end

      def self.included(base)
        base.extend(ApiResource)
      end
    end
  end
end