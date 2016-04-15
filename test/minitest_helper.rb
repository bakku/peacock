$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start

require 'peacock'
require 'fileutils'
require 'open3'
require 'minitest/autorun'
