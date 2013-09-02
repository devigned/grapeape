require 'grape_ape'

class Api < GrapeApe::API
  get '/', worker: 'foo', method: 'hello_world'
end