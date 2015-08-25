# app/controllers/hello_world_controller.rb
class HelloWorldController < ApplicationController
  def hello_world
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
  end
end