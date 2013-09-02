require 'spec_helper'

describe GrapeApe::API do
  context '#route' do
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
      }.to change { described_class.endpoints.count }.from(1).to(2)
    end
  end
end