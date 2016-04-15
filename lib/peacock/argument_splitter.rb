module Peacock

  class ArgumentSplitter

    HYPHEN = '-'
    SINGLE_ARGUMENT_LENGTH = 2

    def split_multiple_arguments!
      ARGV.each do |arg|
        if multiple_argument?(arg)
          split_multiple_argument_in_single_arguments!(arg)
        end
      end
    end

    def multiple_argument?(argument)
      argument.start_with?(HYPHEN) && argument.size > SINGLE_ARGUMENT_LENGTH
    end

    def split_multiple_argument_in_single_arguments!(argument)
      ARGV.delete(argument)
      argument_parts = argument.split('')

      argument_parts.each do |part|
        next if part == HYPHEN
        ARGV << "#{HYPHEN}#{part}"
      end
    end

  end

end