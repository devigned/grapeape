require 'grapeape'

class Worker < GrapeApe::Worker
  worker_key :foo

  def hello_world

  end
end