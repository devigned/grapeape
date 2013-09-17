require 'grape_ape'

class Api < GrapeApe::API
  format :json

  get '/', routing_key: 'foo', method: 'hello_world'
end