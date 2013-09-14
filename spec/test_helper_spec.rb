require 'spec_helper'
require 'grape_ape/test_helper'

describe GrapeApe::TestHelper do
  include GrapeApe::TestHelper

  class TestApi < GrapeApe::API
    format :json

    get '/' do
      {hello: 'world'}
    end
  end

  it 'should make a request to root and get a 200' do
    with_api(TestApi) do
      em_http_client = get_request path: '/'
      em_http_client.response_header.status.should eq(200)
    end
  end

  it 'should make a request to root and get a 200' do
    with_api(TestApi) do
      em_http_client = get_request path: '/'
      JSON.parse(em_http_client.response).should eq({'hello' => 'world'})
    end
  end

end