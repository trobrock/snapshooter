require 'fileutils'

module Snapshooter
  module Storage
    class Local < Base
      def save(filename, &block)
        with_log("Save snapshots/#{filename} to local") do
          FileUtils.mkdir_p "snapshots" unless File.exists?("snapshots")

          file = Tempfile.new("snapshooter_local_storage")
          file.close

          begin
            yield file.path

            File.open "snapshots/#{filename}", "w" do |f|
              f.write File.read(file.path)
            end
          ensure
            file.unlink
          end
        end
      end

      def get(filename, &block)
        yield "snapshots/#{filename}"
      end
    end
  end
end
