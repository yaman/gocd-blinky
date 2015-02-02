require 'chicanery/cctray'
require 'chicanery/git'
require 'blinky'
require 'blink1'

include Chicanery::Git
include Chicanery::Cctray

cctray 'go', 'http://ci.hepsiburada.com/go/cctray.xml'

poll_period 5


LIGHTS = {
   'SUCCESS' => [400, 0, 231, 0],
   'FAILURE' => [400, 255, 0, 0]
}

SUCCESS = "SUCCESS"
FAILURE = "FAILURE"

when_run do |state|
  state[:servers]["go"].delete_if { |v|
    !(v.include? "Storefront.Web" or
      v.include? "ProductInformation")
    }
  if state.has_failure?
    blink(FAILURE)
  else
    blink(SUCCESS)
  end
  puts state.has_failure? ? "something is wrong" : "all builds are fine"
end

def blink (status)
  if status.include? SUCCESS
    Blinky.new.light.success!
    Blink1.open do |blink|
      blink.blink(*LIGHTS[SUCCESS])
    end
  end

  if status.include? FAILURE
    Blinky.new.light.failure!
    Blink1.open do |blink|
      blink.blink(*LIGHTS[FAILURE])
    end
  end
end
