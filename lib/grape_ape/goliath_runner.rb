require 'grape_ape/api'
require 'grape_ape/server'

Goliath::Application.module_eval do

  Goliath::Application::CALLERS_TO_IGNORE << /\/grape_ape\/goliath_runner.rb$/
  Goliath::Application::CALLERS_TO_IGNORE << /\/ruby-debug-ide-(.+)\//
  Goliath::Application::CALLERS_TO_IGNORE << /\/debase\//

  module_function

  def camel_case(str)
    return str if str !~ /_/ && str =~ /[A-Z]+.*/

    str.split('_').map { |e| e.capitalize }.join
  end

  alias :super_run! :run!

  # Execute the application
  #
  # @return [Nil]
  def run!
    if GrapeApe::API.app_class
      begin
        klass = Kernel
        GrapeApe::API.app_class.split('::').each { |con| klass = klass.const_get(con) }
        api = GrapeApe::Server.new(api: klass)
      rescue NameError
        raise NameError, "Class #{@app_class} not found."
      end

      runner = Goliath::Runner.new(ARGV, api)
      runner.app = Goliath::Rack::Builder.build(GrapeApe::Server, api)

      runner.load_plugins(GrapeApe::Server.plugins)
      runner.run
    else
      super_run!
    end
  end

end
