# Peacock

Peacock is a small tool to easily manage your .gitignore written in ruby.

It lets you extract files and directories from .gitignore files as well as inserting new files to .gitignore

Note that at the moment you can't combine options with one hyphen (e.g.: -es for --extract and --silent) but you have to pass them separated (e.g.: -e -v)

## Installation

Install by executing:

    $ gem install peacock

## Usage

Usage:

    peacock [options] [files/directories]
  
Options:

    -h, [--help]        # show this text
    -r, [--root]        # use root .gitignore
    -s, [--silent]      # suppress output
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
    ...
    Untracked files:
        these
        files
    
    $ peacock -e are
    removed are from .gitignore
    
    $ git status
    ...
    Untracked files:
        these
	    are
	    files

    
## TODO

Issues are used for TODOs

## Contributing

1. Fork it ( https://github.com/bakku/peacock/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
