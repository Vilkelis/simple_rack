# frozen_string_literal: true

# Time format service
class TimeFormatService
  TIME_FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d',
                   'hour' => '%H', 'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(format_string)
    @format_string = format_string
    @format_keys = @format_string.scan(/[a-zA-Z]+/)
  end

  def format_time(time)
    format_template = @format_string
    @format_keys.each do |f|
      format_template.gsub!(f, TIME_FORMATS[f])
    end

    time.strftime(format_template)
  end

  def format_valid?
    (@format_keys - TIME_FORMATS.keys).empty?
  end

  def format_error
    return if format_valid?

    bad_format = @format_keys - TIME_FORMATS.keys
    'Unknown time format ' + bad_format.to_s
  end
end
