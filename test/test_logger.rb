require 'minitest_helper'

class TestLogger < Minitest::Test

  def test_should_print_ignore_by_default
    logger = Peacock::Logger.new(false)
    assert_output "added test.rb to .gitignore\n" do
      logger.ignore 'test.rb'
    end
  end

  def test_should_print_extract_by_default
    logger = Peacock::Logger.new(false)
    assert_output "removed test.rb from .gitignore\n" do
      logger.extract 'test.rb'
    end
  end

  def test_should_not_print_ignore
    logger = Peacock::Logger.new(true)
    assert_output '' do
      logger.ignore 'test.rb'
    end
  end

  def test_should_not_print_extract
    logger = Peacock::Logger.new(true)
    assert_output '' do
      logger.extract 'test.rb'
    end
  end

end
