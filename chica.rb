require 'chicanery/cctray'
require 'chicanery/git'
require 'blinky'

include Chicanery::Git
include Chicanery::Cctray

cctray 'go', 'http://ci.hepsiburada.com/go/cctray.xml'

poll_period 5

light = Blinky.new.light 

when_run do |state|
  state[:servers]["go"].delete_if { |v|
    !(v.include? "Storefront.Web" or
        v.include? "Storefront.Journey.Tests" or
        v.include? "Storefront.Regression.Tests" or
        v.include? "Storefront.Performance.Tests" or
        v.include? "Storefront.MobilePerformance.Tests" or
        v.include? "ProductSearch.Service" or
        v.include? "ProductInformation.Service" or
        v.include? "Campaigns.Service" or
        v.include? "Categories.Service" or
        v.include? "Recommendations.Service" or
        v.include? "ProductReviews.Service" or
        v.include? "ContentManagement.Service" or
        v.include? "ContentManagementAdmin.Service" or
        v.include? "User.Service" or
        v.include? "Storefront.Cache" or
        v.include? "DeployAllStorefront" or
        v.include? "BuildAndDeliver")
    }
  if state.has_failure?
    light.failure!
  else
    light.success!
  end
  puts state.has_failure? ? "something is wrong" : "all builds are fine"
end
