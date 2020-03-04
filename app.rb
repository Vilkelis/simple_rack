# frozen_string_literal: true

require_relative 'helpers/http_answer_helper'
require_relative 'controllers/time_format_controller'

# Application routing
class App
  include HttpAnswerHelper

  def call(env)
    request = Rack::Request.new(env)
    if request.get? && request.path == '/time'
      TimeFormatController.new(request).format_current_time
    else
      respond 'Bad request', HTTP_ANSWER_INVALID_URL
    end
  end
end
