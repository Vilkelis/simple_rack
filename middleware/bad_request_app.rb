# frozen_string_literal: true

require_relative '../helpers/http_answer_helper'

# Simple Error sending Rack app
class BadRequestApp
  include HttpAnswerHelper

  def call(_env)
    respond 'Bad request', HTTP_ANSWER_INVALID_URL
  end
end
