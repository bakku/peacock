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
    @parser = Peacock::CLI.new
    assert @parser.should_print_help?
  end
  
  def test_should_print_help_should_be_true_for_option_h
    @parser = Peacock::CLI.new
    ARGV[0] = '-h'
    assert @parser.should_print_help?
  end
  
  def test_should_print_help_should_be_true_for_option_help
    @parser = Peacock::CLI.new
    ARGV[0] = '--help'
    assert @parser.should_print_help?
  end
  
  def test_determine_type_should_be_dirs_for_directories
    @parser = Peacock::CLI.new
    Dir.mkdir 'test_determine_type_should_be_dirs_for_directories'
    type = @parser.determine_type 'test_determine_type_should_be_dirs_for_directories'
    assert_equal :dirs, type
    Dir.rmdir 'test_determine_type_should_be_dirs_for_directories'
  end
  
  def test_determine_type_should_be_files_for_files
    @parser = Peacock::CLI.new
    FileUtils.touch 'test_determine_type_should_be_files_for_files'
    type = @parser.determine_type 'test_determine_type_should_be_files_for_files'
    assert_equal :files, type
    FileUtils.rm 'test_determine_type_should_be_files_for_files'
  end
  
  def test_determine_type_should_be_opts_for_options
    @parser = Peacock::CLI.new
    type = @parser.determine_type '-r'
    assert_equal :opts, type
  end
  
  def test_determine_type_should_be_nil
    @parser = Peacock::CLI.new
    refute @parser.determine_type 'not_available'
  end
  
  def test_parse_hash_should_be_as_expected
    @parser = Peacock::CLI.new
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
    
    Dir.rmdir 'test_dir'
    FileUtils.rm 'test_file'
  end
end
