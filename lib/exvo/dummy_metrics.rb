module Exvo
  class DummyMetrics
    def method_missing(method, *args, &block)
      true
    end
  end
end
