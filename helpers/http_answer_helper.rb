# frozen_string_literal: true

# Helpers for rack applications
module HttpAnswerHelper
  HTTP_ANSWER_OK = 200
  HTTP_ANSWER_PARAMS_ERROR = 400
  HTTP_ANSWER_FORMAT_ERROR = 400
  HTTP_ANSWER_INVALID_URL = 404

  private

  def handler
    { 'Content-Type' => 'text/plain' }
  end

  def respond(text, status = HTTP_ANSWER_OK)
    [status, handler, [text]]
  end
end
