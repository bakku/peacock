require 'minitest_helper'
require 'fileutils'

class TestParser < Minitest::Test
  
  def setup
    @parser = Peacock::Parser.new
    Dir.mkdir '/tmp/temptest'
    Dir.chdir '/tmp/temptest'
  end
  
  def teardown
    Dir.chdir '/tmp'
    FileUtils.rm_rf 'temptest'
  end
  
  def test_should_print_help_should_be_true_for_empty_argv
    assert @parser.should_print_help?
  end
  
  def test_should_print_help_should_be_true_for_option_h
    ARGV[0] = '-h'
    assert @parser.should_print_help?
  end
  
  def test_should_print_help_should_be_true_for_option_help
    ARGV[0] = '--help'
    assert @parser.should_print_help?
  end
  
  def test_determine_type_should_be_dirs_for_directories
    Dir.mkdir 'test'
    type = @parser.determine_type 'test'
    assert_equal :dirs, type
  end
  
  def test_determine_type_should_be_files_for_files
    FileUtils.touch 'test'
    type = @parser.determine_type 'test'
    assert_equal :files, type
  end
  
  def test_determine_type_should_be_opts_for_options
    type = @parser.determine_type '-r'
    assert_equal :opts, type
  end
  
end
