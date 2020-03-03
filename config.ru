# frozen_string_literal: true

require_relative 'middleware/bad_request_app.rb'
require_relative 'middleware/time_app.rb'

use TimeApp
run BadRequestApp.new
