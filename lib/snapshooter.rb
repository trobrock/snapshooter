require 'snapshooter/version'
require 'snapshooter/log'
require 'snapshooter/base'
require 'snapshooter/cli'
require 'snapshooter/storage/base'
require 'snapshooter/storage/local'
require 'snapshooter/storage/s3'

module Snapshooter
  mattr_accessor :datastores, :environment, :application_name
end
