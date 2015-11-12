# Peacock

Peacock is a small tool to easily manage your .gitignore written in ruby.

It lets you ignore and extract files and directories using .gitignore in your current git repository.

Note that while ignoring files and directories peacock will perform safety commits to make sure your work is not lost. It will commit all your uncommited work (if there is any) before and after adding files to .gitignore.

While extracting, peacock leaves everything untouched.

Note that at the moment you can't combine options with one hyphen (e.g.: -ev for --extract and --verbose) but you have to pass them separated (e.g.: -e -v)

## Installation

Install by executing:

    $ gem install peacock

## Usage

Usage:

    peacock [options] [files/directories]
  
Options:

    -h, [--help]        # show this text
    -r, [--root]        # use root .gitignore
    -v, [--verbose]     # surpress output
    -e, [--extract]     # extract file from .gitignore

## Example

    $ git status
    ...
    Untracked files:
	    these
	    are
	    some
	    files
    
    $ peacock are some
    added are to .gitignore
    added some to .gitignore
    
    $ git status
    On branch master
    nothing to commit, working directory clean
    
    $ peacock -e are
    removed are from .gitignore
    
    $ git status
    ...
    Untracked files:
	    are

    
## TODO

- add functionalities
- custom commit messages
- comments in .gitignore
- options can't be combined (e.g. -ev for extract and surpress)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/peacock/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
