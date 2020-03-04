# frozen_string_literal: true

require_relative '../helpers/http_answer_helper'
require_relative '../services/time_format_service'

# Time format controller
class TimeFormatController
  include HttpAnswerHelper

  TIME_FORMAT_PARAM = 'format'

  def initialize(request)
    @request = request
    @params = request.params
  end

  def format_current_time
    return params_error unless params_valid?

    time_service = TimeFormatService.new(@params[TIME_FORMAT_PARAM])

    return respond time_service.format_error unless time_service.format_valid?

    respond time_service.format_time(Time.now)
  end

  private

  # Returns respond with error text
  def params_error
    return if params_valid?

    if @params.empty?
      respond 'No parameters set', HTTP_ANSWER_INVALID_URL
    else
      bad_params = @params.keys - [TIME_FORMAT_PARAMETER]
      respond 'Unknown parameter ' + bad_params.to_s, HTTP_ANSWER_INVALID_URL
    end
  end

  # Request params validator
  def params_valid?
    @params.count == 1 && @params.key?(TIME_FORMAT_PARAM)
  end
end
