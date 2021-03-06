require 'chicanery/cctray'
require 'chicanery/git'
require 'blinky'

include Chicanery::Git
include Chicanery::Cctray

cctray 'go', 'http://go.mycompany.com/go/cctray.xml'

poll_period 5

light = Blinky.new.light 

when_run do |state|
  state[:servers]["go"].delete_if { |v|
    !(v.include? "MyPipeline1" or
       v.include? "MyPipeline2")
    }
  if state.has_failure?
    light.failure!
  else
    light.success!
  end
  puts state.has_failure? ? "something is wrong" : "all builds are fine"
end
