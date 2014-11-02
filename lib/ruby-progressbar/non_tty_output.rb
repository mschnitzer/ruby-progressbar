require 'ruby-progressbar/output'

class ProgressBar
  class NonTtyOutput < Output
    DEFAULT_FORMAT_STRING = '%t: |%b|'

    def clear
      self.last_update_length = 0

      stream.print "\n"
    end

    def last_update_length
      @last_update_length ||= 0
    end

    def bar_update_string
      formatted_string        = bar.to_s(DEFAULT_FORMAT_STRING)
      formatted_string        = formatted_string[0...-1] unless bar.finished?

      output_string           = formatted_string[last_update_length..-1]
      self.last_update_length = formatted_string.length

      output_string
    end

    def update_with_format_change(&block); end

    def eol
      bar.stopped? ? "\n" : ""
    end

    protected

    attr_accessor :last_update_length
  end
end
