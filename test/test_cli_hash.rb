require 'minitest_helper'

class TestCLI < Minitest::Test
  
  def setup
    @hash = Peacock::CLIHash.new
    Dir.mkdir '/tmp/temptest'
    Dir.chdir '/tmp/temptest'
  end
  
  def teardown
    Dir.chdir '/tmp'
    FileUtils.rm_rf 'temptest'
    ARGV.clear
  end
  
  def test_push_to_opts
    @hash.push(:opts, '-r')
    assert @hash.opts.include?('-r')
  end
  
  def test_root_ignore_should_be_true_for_r
    @hash.push(:opts, '-r')
    assert @hash.root_ignore?
  end
  
  def test_root_ignore_should_be_true_for_root
    @hash.push(:opts, '--root')
    assert @hash.root_ignore?
  end
  
  def test_root_ignore_should_be_true_for_both
    @hash.push(:opts, '-r')
    @hash.push(:opts, '--root')
    assert @hash.root_ignore?
  end
  
  def test_root_ignore_should_be_false_without_r_or_root
    @hash.push(:opts, '-e')
    @hash.push(:opts, '--bla')
    refute @hash.root_ignore?
  end
  
  def test_root_ignore_should_be_false_for_empty
    refute @hash.root_ignore?
  end

end
