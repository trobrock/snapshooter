module Snapshooter
  module Storage
    class Base
      include Log

      def save(filename, &block)
        raise "NotImplemented"
      end

      def get(filename, &block)
        raise "NotImplemented"
      end
    end
  end
end
