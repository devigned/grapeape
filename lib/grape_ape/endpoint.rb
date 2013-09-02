module GrapeApe
  class Endpoint < Grape::Endpoint
    include GrapeApe::Dispatcher
  end
end