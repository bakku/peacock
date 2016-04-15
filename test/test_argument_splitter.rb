require 'minitest_helper'

class TestArgumentSplitter < Minitest::Test

  def setup
    @argument_splitter = Peacock::ArgumentSplitter.new
  end

  def teardown
    ARGV.clear
  end

  def test_one_argument_should_be_not_multiple
    argument_string = '-e'
    refute @argument_splitter.multiple_argument?(argument_string)
  end

  def test_two_arguments_should_be_detected
    argument_string = '-ev'
    assert @argument_splitter.multiple_argument?(argument_string)
  end

  def test_three_arguments_should_be_detected
    argument_string = '-evs'
    assert @argument_splitter.multiple_argument?(argument_string)
  end

  def test_two_arguments_should_be_splitted_correctly
    argument = '-ev'
    ARGV << argument
    @argument_splitter.split_multiple_argument_in_single_arguments!(argument)
    assert_equal 2, ARGV.size
    assert_equal '-e', ARGV.first
    assert_equal '-v', ARGV[1]
  end

  def test_three_arguments_should_be_splitted_correctly
    argument = '-evs'
    ARGV << argument
    @argument_splitter.split_multiple_argument_in_single_arguments!(argument)
    assert_equal 3, ARGV.size
    assert_equal '-e', ARGV.first
    assert_equal '-v', ARGV[1]
    assert_equal '-s', ARGV[2]
  end

  def test_mixed_arguments_should_be_transformed_correctly
    ARGV << '-e'
    ARGV << '-vs'
    @argument_splitter.split_multiple_arguments!
    assert_equal 3, ARGV.size
    assert_equal '-e', ARGV.first
    assert_equal '-v', ARGV[1]
    assert_equal '-s', ARGV[2]
  end

end
