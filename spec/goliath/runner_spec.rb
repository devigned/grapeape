require 'spec_helper'

describe GrapeApe::Goliath::Runner do

  let(:subject) { described_class.new([], nil) }

  context '#setup_server' do
    it 'should setup the server with the proper properties' do
      server = double('server')
      GrapeApe::Goliath::Server.should_receive(:new).and_return(server)
      server.should_receive(:logger=)
      server.should_receive(:app=)
      server.should_receive(:api=)
      server.should_receive(:plugins=)
      server.should_receive(:options=)
      subject.setup_server.should eq(server)
    end
  end
end
