require 'spec_helper'

describe GrapeApe::Dispatcher do
  include EventedSpec::AMQPSpec

  let(:subject) { Class.new { extend GrapeApe::Dispatcher } }

  context '#rpc' do
    let(:correlation_id) { SecureRandom.uuid }
    let(:env) { OpenStruct.new(correlation_id: correlation_id) }
    let(:em_channel) { EM::Channel.new }
    let(:amqp_channel) { AMQP::Channel.new }
    let(:response_queue) { SecureRandom.uuid }
    let(:message) { {foo: 'bar'} }
    let(:queue_name) { 'request_queue' }

    amqp_before do
      env.should_receive(:grape_amqp_em_channel).and_return(em_channel)
      env.should_receive(:grape_amqp_response_queue).and_return(response_queue)
      exchange = amqp_channel.default_exchange
      exchange.should_receive(:publish)
      env.should_receive(:grape_amqp_exchange).and_return(exchange)
    end

    it 'should request, then reply back to the dispatcher' do
      Fiber.new {
        delayed(0.2) {
          em_channel.push({meta: OpenStruct.new(correlation_id: correlation_id), data: message})
          done
        }
        subject.rpc(env, :foo, message).should eq(message)
      }.resume
    end

    it 'should publish a message to the queue' do
      Fiber.should_receive(:yield)
      JSON.should_receive(:parse)
      subject.rpc(env, queue_name, message)
      done
    end
  end

end
