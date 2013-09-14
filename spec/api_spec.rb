require 'spec_helper'

describe GrapeApe::API do

  before(:each) do
    described_class.endpoints.clear
  end

  subject { Class.new(GrapeApe::API) }

  def app;
    subject
  end

  describe '.route' do
    let(:ape_options) { {worker: 'blah', method: 'hello'} }

    it 'should ask if the route is an ape route' do
      described_class.should_receive(:ape_route?).with(hash_including(ape_options)).and_return(true)
      described_class.route(:get, '/', ape_options)
    end

    it 'should call super route with no ape route options' do
      described_class.superclass.should_receive(:route)
      described_class.route(:get, '/')
    end

    it 'should add an endpoint to the endpoint collection' do
      expect {
        described_class.route(:get, '/', ape_options)
      }.to change { described_class.endpoints.count }.from(0).to(1)
    end

    context 'api responses' do
      it 'returns the message that rpc returns with out a block provided to the dsl method' do
        subject.get '/', ape_options
        GrapeApe::Endpoint.any_instance.should_receive(:rpc).and_return('hello_world')
        get '/'
        last_response.body.should eql 'hello_world'
      end

      it 'should pass the rpc message to the provided block for processing' do
        subject.get '/', ape_options do |message|
          'hello ' + message
        end
        GrapeApe::Endpoint.any_instance.should_receive(:rpc).and_return('world')
        get '/'
        last_response.body.should eql 'hello world'
      end
    end
  end
end