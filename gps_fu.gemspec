Gem::Specification.new do |s|
  s.name = "gps_fu"
  s.version = "0.0.1"
  s.date = "2008-09-25"
  s.summary = "API for myGPSID.com"
  s.email = "pete@peteonrails.com"
  s.homepage = "http://blog.peteonrails.com/gps"
  s.description = "GPSFu provides the ability to translate myGPSId.com address IDs into geo-location XML packets."
  s.has_rdoc = false
  s.authors = ["Peter Jackson"]
  s.files = [ "init.rb",
              "LICENSE",
              "README",
              "lib/gps_fu.rb",
              "rails/init.rb",
              "spec/gps_fu_mygpsid_spec.rb",
              "spec/spec.opts",
              "spec/spec_helper.rb"
               ]
end