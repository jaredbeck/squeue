require_relative 'squeue'
require 'test/unit'
require 'rack/test'

class SqueueTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_post
    post '/q', input: "herp"
    assert_equal 201, last_response.status
  end

  def test_get
    get '/q'
    assert_equal 404, last_response.status
    assert_equal "empty", last_response.body

    request '/q', method: :post, input: "derp"
    assert_equal 201, last_response.status

    get '/q'
    assert_equal 200, last_response.status
    assert_equal "derp", last_response.body

    get '/q'
    assert_equal 409, last_response.status
    assert_equal "locked", last_response.body
  end

  def test_delete
    delete '/q'
    assert_equal 404, last_response.status
    assert_equal 'empty', last_response.body
  end
end

