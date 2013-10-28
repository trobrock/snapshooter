module Snapshooter
  module Log
    def with_log(message, &block)
      t0 = Time.now
      puts "[START] #{message}"
      result = yield
      t1 = Time.now
      puts "[END] #{message} (it took #{(t1-t0)/60.0} minutes)"
      result
    end
  end
end
