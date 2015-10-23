require 'minitest_helper'

class TestGit < Minitest::Test
  
  def setup
    Dir.mkdir '/tmp/temptest'
    Dir.chdir '/tmp/temptest'
  end
  
  def teardown
    Dir.chdir '/tmp'
    FileUtils.rm_rf 'temptest'
    ARGV.clear
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
  end
  
  def test_git_commit_all_should_return_correct_output
    Git.init
    FileUtils.touch 'file.txt'
    Git.commit_all('test')
    output = Git.log
    assert output.include?('commit')
    assert output.include?('test')
  end
  
end