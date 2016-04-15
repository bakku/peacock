require 'minitest_helper'

class TestGit < Minitest::Test

  def setup
    Dir.mkdir '/tmp/peacock'
    Dir.chdir '/tmp/peacock'
  end

  def teardown
    FileUtils.rm_rf '/tmp/peacock'
    ARGV.clear
  end

  def test_base_command_should_call_git
    output = Git.git
    assert output.include? 'These are common Git commands used in various situations'
  end

  def test_git_new_should_raise_exception
    assert_raises NoGitRepositoryError do
      Git.check_repo_existance
    end
  end

  def test_git_init_should_return_correct_output
    output = Git.init
    assert output.include?('Initialized empty Git repository')
    Dir.exists?('.git')

    # should not raise an exception now
    Git.check_repo_existance
  end

  def test_git_status_should_return_correct_output
    Git.init
    output = Git.status
    assert output.include?('Initial commit')
    assert output.include?('nothing to commit')
    FileUtils.touch 'file.txt'
    Git.commit_all('initial commit')

    output = Git.status
    assert output.include?('On branch master')
    assert output.include?('nothing to commit')

    FileUtils.rm 'file.txt'
    output = Git.status
    assert output.include?('Changes not staged for commit')
    assert output.include?('deleted')
    assert output.include?('file.txt')
  end

  def test_git_commit_all_should_return_correct_output
    Git.init
    FileUtils.touch 'file.txt'
    Git.commit_all('test')
    output = Git.log
    assert output.include?('commit')
    assert output.include?('test')
  end

  def test_git_remove_from_cache_should_work_as_expected
    Git.init
    FileUtils.touch 'file.txt'
    Git.commit_all 'initial commit'
    Git.remove_from_cache 'file.txt'
    output = Git.status
    assert output.include?('deleted')
    assert output.include?('file.txt')
  end

  def test_git_clear_cache_should_work_as_expected
    Git.init
    FileUtils.touch 'file.txt'
    FileUtils.touch 'file2.txt'
    Git.commit_all 'initial commit'
    Git.clear_cache
    output = Git.status
    assert output.include?('deleted')
    assert output.include?('file.txt')
    assert output.include?('file2.txt')
  end
end
