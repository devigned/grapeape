lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'grape_ape'

class Api < GrapeApe::API
  format :json

  get '/' do
    {something: 'hello world'}
  end

  #, worker: 'foo', method: 'hello_world'
end