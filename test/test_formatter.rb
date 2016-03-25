require 'minitest_helper'

class TestFormatter < Minitest::Test

  def test_format_dir_with_no_slash
    result = Peacock::Formatter.format_dir 'dir'
    assert_equal '/dir/', result
  end

  def test_format_dir_with_beginning_slash
    result = Peacock::Formatter.format_dir '/dir'
    assert_equal '/dir/', result
  end

  def test_format_dir_with_ending_slash
    result = Peacock::Formatter.format_dir 'dir/'
    assert_equal '/dir/', result
  end

  def test_format_dir_with_both_slashes
    result = Peacock::Formatter.format_dir '/dir/'
    assert_equal '/dir/', result
  end

end
