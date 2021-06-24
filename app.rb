require 'rack'
require_relative 'date_format'

class App
  def call(env)
    request = Rack::Request.new(env)
    request_valid?(request) ? exec_request(request) : bad_request
  end

  private

  def request_valid?(request)
    request.get? && request.path == '/time' && request.params['format']
  end

  def exec_request(request)
    params = request.params['format']
    @date_format = DateFormat.new(params)
    @date_format.check_formats
    @date_format.success? ? success : unknown_formats
  end

  def success
    response(200, @date_format.format)
  end

  def bad_request
    response(404, 'Page not found')
  end

  def unknown_formats
    response(400, "Unknown time format #{@date_format.rejected_params}")
  end

  def response(status, body)
    Rack::Response.new(body, status, {'Content-Type' => 'text/plain'}).finish
  end
end
