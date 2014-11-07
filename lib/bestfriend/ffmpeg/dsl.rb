module BestFriend::FFmpeg
  module DSL
    def self.included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def ffmpeg
    end
  end
end
