require 'grape_ape'

class Worker < GrapeApe::Worker
  routing_key :foo

  def hello_world(request)
    'Hello World!!'
  end
end
