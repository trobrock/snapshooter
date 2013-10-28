require 'optparse'

module Snapshooter
  class CLI
    def self.start
      new.run
    end

    def initialize
      @options = {
        :storage => :local,
        :id      => Time.now.to_i,
        :restore => false
      }
      @options.merge! parse_options
    end

    def run
      shooter = Base.new(@options[:id], @options[:storage])
      if @options[:restore]
        shooter.restore
      else
        shooter.snapshot!
      end
    end

    private

    def parse_options
      options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: script/snapshot [options]"

        opts.on("-i", "--id [IDENTIFIER]", "The identifier for the snapshot (default current timestamp)") do |identifier|
          options[:id] = identifier
        end

        opts.on("-s", "--storage [STORAGE]", "Select the storage mechanism to use (default local)") do |storage|
          options[:storage] = storage.to_sym
        end

        opts.on("--restore", "Restores a snapshot given the identifier") do
          options[:restore] = true
        end
      end.parse!

      options
    end
  end
end
