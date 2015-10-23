require 'minitest_helper'

class TestCLI < Minitest::Test
  
  def setup
    @parser = Peacock::CLI.new
    Dir.mkdir '/tmp/temptest'
    Dir.chdir '/tmp/temptest'
  end
  
  def teardown
    Dir.chdir '/tmp'
    FileUtils.rm_rf 'temptest'
    ARGV.clear
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
  
  def test_determine_type_should_be_nil
    refute @parser.determine_type 'not_available'
  end
  
  def test_parse_hash_should_be_as_expected
    Dir.mkdir 'test_dir'
    FileUtils.touch 'test_file'
    
    ARGV << '-r'
    ARGV << 'test_file'
    ARGV << 'test_dir'
    
    hash = @parser.parse_args
    
    assert_equal 1, hash.dirs.size
    assert_equal 1, hash.files.size
    assert_equal 1, hash.opts.size
    
    assert_equal 'test_dir', hash.dirs.first
    assert_equal 'test_file', hash.files.first
    assert_equal '-r', hash.opts.first
  end
end
