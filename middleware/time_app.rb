# frozen_string_literal: true

require_relative '../helpers/http_answer_helper'

# Get Time service
class TimeApp
  include HttpAnswerHelper

  TIME_FORMAT_PARAM = 'format'
  TIME_FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d',
                   'hour' => '%H', 'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.get? && request.path == '/time'
      time request.params
    else
      @app.call(env)
    end
  end

  private

  def time(params)
    return params_error(params) unless params_valid?(params)

    format_str = params[TIME_FORMAT_PARAM]
    format = format_str.scan(/[a-zA-Z]+/)
    return format_error(format) unless format_valid?(format)

    format.each do |f|
      format_str.gsub!(f, TIME_FORMATS[f])
    end

    respond Time.now.strftime(format_str)
  end

  def params_error(params)
    if params.empty?
      respond 'No parameters set', HTTP_ANSWER_INVALID_URL
    else
      bad_params = params.keys - [TIME_FORMAT_PARAMETER]
      respond 'Unknown parameter ' + bad_params.to_s, HTTP_ANSWER_INVALID_URL
    end
  end

  def format_error(format)
    bad_format = format - TIME_FORMATS.keys
    respond 'Unknown time format ' + bad_format.to_s, HTTP_ANSWER_FORMAT_ERROR
  end

  # Request params validator
  def params_valid?(params)
    params.count == 1 && params.key?(TIME_FORMAT_PARAM)
  end

  # Time format validator
  def format_valid?(format)
    (format - TIME_FORMATS.keys).empty?
  end
end
