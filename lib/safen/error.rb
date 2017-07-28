module Safen
  class SafenError < StandardError
    attr_reader :code

    def initialize(code = nil)
      @code = code
    end
  end
end