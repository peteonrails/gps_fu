require 'net/http'
require 'hpricot'
require 'cgi'

module GPSFu

  module MyGPSId
        
    class RequestError < StandardError; end
    
    class Location
      attr_reader :state, :country_code, :city, :lat, :lng, :postal_code, :postal_district
      
      def initialize(response)
        @city = (response.xml/"address/city").inner_html
        @state = (response.xml/"address/state").inner_html
        @postal_code = (response.xml/"address/postal_code").inner_html
        @postal_district = (response.xml/"address/postal_district").inner_html
        @lat = (response.xml/"address/lat").inner_html
        @lng = (response.xml/"address/lng").inner_html
        @country_code = (response.xml/"address/country-code").inner_html
      end
        
      def latitude 
        @lat
      end
      def longitude
        @lng
      end
    end
    
    
    
    class Client
      SERVICE_URL = "http://www.mygpsid.com"
      API_VERSION = "V1"
      @@options = { }
      @@services = 
      {
        :id_to_geocode  => "address_services"
      }
      
      ERRORS = {
        400 => "Invalid Request – requires a valid API key",
        401 => "Invalid API Key",
        404 => "Malformed and Invalid API request"
      }
      
      def self.options
        @@options
      end
      
      def self.options=(opts)
        @@options = opts
      end

      def self.id_to_geocode(address_id, opts = {})
        opts[:service] = :id_to_geocode
        opts[:address_id] = address_id
        self.send_request(opts)
      end
      
      # This method requires several options:
      # :address_id -- required
      # :api_key -- unless you have already set it in the client. 
      # :service -- required (try :id_to_geocode)
      def self.send_request(opts = {})
        opts = self.options.merge(opts) if self.options
        request_url = build_url(opts)
        rsp = Net::HTTP.get_response(URI::parse(request_url))
        raise GPSFu::MyGPSId::RequestError, "#{rsp.code} #{ERRORS[rsp.code]}" unless rsp.kind_of? Net::HTTPSuccess  
        Response.new(rsp.body)
      end

      protected
      def self.build_url(opts = {})
        opts = self.options.merge(opts) if self.options
        url = "#{SERVICE_URL}/#{API_VERSION}/#{@@services[opts[:service]]}/#{opts[:address_id]}?key=#{opts[:api_key]}"
      end
    end
    
    class Response
      def initialize(_xml)
        @xml = Hpricot(_xml)
      end

      def xml
        @xml
      end
    end
  end
end
