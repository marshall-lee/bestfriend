module BestFriend
  class FFmpeg
    cattr_accessor :binary
    attr_accessor :binary

    def initialize
      if block_given?
        instance_eval(proc)
      end
    end
  end
end
