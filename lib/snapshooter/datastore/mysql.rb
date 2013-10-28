require 'digest/md5'

module Snapshooter
  module Datastore
    class Mysql
      def initialize(options={})
        @options = options
      end

      def snapshot(tmp_file)
        `mysqldump #{mysqldump_options} #{@options[:database]} > #{tmp_file}`
      end

      def restore(file)
        `mysql #{mysql_options} #{@options[:database]} < #{file}`
      end

      def filename
        "#{id}.sql"
      end

      private

      def id
        Digest::MD5.hexdigest(@options.to_s)
      end

      def mysql_options
        options = []
        options << "-u#{@options[:user]}"     if @options[:user]
        options << "-p#{@options[:password]}" if @options[:password]
        options << "-h#{@options[:host]}"     if @options[:host]

        options.join(" ")
      end

      def mysqldump_options
        ["--single-transaction", mysql_options].join(" ")
      end
    end
  end
end
