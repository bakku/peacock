# Peacock

Peacock is a small tool to easily manage your .gitignore written in ruby.

At the moment, Peacock can only be executed from the root directory of your repository.

In order to perform your changes on .gitignore, peacock will automatically add all current files to the index
and perform a commit before and after you execute peacock.

## Installation

Add this line to your application's Gemfile:

Install by executing:

    $ gem install peacock

## Usage

Usage:

    peacock [options] [files/directories]
  
Options:

    -h, [--help]        # show this text
    -r, [--root]        # use root .gitignore
    -v, [--verbose]     # surpress output
    -e, [--extract]     # extract file from .gitignore (not functional yet)
    -l, [--list]        # list all ignored directories and files (not functional yet)

## TODO

- add functionalities
- custom commit messages
- comments in .gitignore

## Contributing

1. Fork it ( https://github.com/[my-github-username]/peacock/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
