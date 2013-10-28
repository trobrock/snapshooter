require 'tempfile'

module Snapshooter
  module Storage
    class S3 < Base
      def save(filename, &block)
        with_log("Save #{bucket}/#{filename} to S3") do
          directory = connection.directories.create(
            :key    => bucket,
            :public => false
          )

          file = Tempfile.new("snapshooter_s3_storage")
          file.close

          begin
            yield file.path

            directory.files.create(
              :key    => filename,
              :body   => File.open(file.path),
              :public => false
            )
          ensure
            file.unlink
          end
        end
      end

      def get(filename, &block)
        directory = connection.directories.get(bucket)
        file      = directory.files.get(filename)

        with_tempfile file.body, &block
      end

      private

      def bucket
        "#{Snapshooter.environment}-snapshots-#{Snapshooter.application_name}"
      end

      def connection
        FogFactory.storage
      end

      def with_tempfile(data)
        file = Tempfile.new("snapshooter_s3_storage")
        file.write data
        file.close

        yield file.path

        file.unlink
      end
    end
  end
end
