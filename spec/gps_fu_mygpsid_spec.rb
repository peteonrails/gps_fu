require File.dirname(__FILE__) + '/spec_helper'

API_KEY = ""
raise "Please put your API KEY into my_gps_id_spec.rb before spec testing!" if API_KEY.empty?
 
include GPSFu::MyGPSId

describe Client, "basic operations" do
  
  it "should be able to build a valid REST URL given certain parameters" do
    url = "http://www.mygpsid.com/V1/address_services/user@location?key=#{API_KEY}"
    Client.build_url(:address_id => "user@location", :api_key => API_KEY, :service => :id_to_geocode).should eql(url)
  end
  
  it "should be able to look up an address id" do
    geocode = Client.id_to_geocode("pjackson@home", :api_key => API_KEY).xml
    (geocode/"address/city").inner_html.should eql("Bethesda")
    (geocode/"address/country-code").inner_html.should eql("US")
  end   
  
#  it "should throw an error when an invalid API KEY is specified"
#  it "should throw an error when the URL is malformed"
#  it "should throw an error when no API key is included"
  
end

describe Location do 
  it "should be able to look up an address id" do
    @loc = Location.new(Client.id_to_geocode("pjackson@home", :api_key=>API_KEY))
    @loc.city.should eql("Bethesda")
    @loc.country_code.should eql("US")
  end
end


