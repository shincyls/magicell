module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      # stream_from "some_channel"
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  
    def speak
    end
  end
end
