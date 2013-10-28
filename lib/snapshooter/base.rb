module Snapshooter
  class Base
    include Log

    def initialize(id, storage=:local)
      @id = id
      case storage
      when :s3
        @storage = Storage::S3.new
      when :local
        @storage = Storage::Local.new
      else
        raise "Unknown storage type: #{storage}"
      end
    end

    def restore
      datastores.each do |datastore|
        filename = "#{@id}-#{datastore.filename}"

        @storage.get filename do |file|
          with_log("Restore from #{filename}") do
            datastore.restore(file)
          end
        end
      end
    end

    def snapshot!
      datastores.each do |datastore|
        filename = "#{@id}-#{datastore.filename}"

        @storage.save filename do |tmp_file|
          with_log "Snapshot to #{filename}" do
            datastore.snapshot tmp_file
          end
        end
      end
    end

    private

    def datastores
      Snapshooter.datastores.map do |store|
        case store[:type]
        when :mysql
          Datastore::Mysql.new(store[:config])
        else
          raise "Unknown Datastore: #{store[:type]}"
        end
      end
    end
  end
end
