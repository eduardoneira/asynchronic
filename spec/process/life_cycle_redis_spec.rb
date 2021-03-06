require 'minitest_helper'
require_relative './life_cycle_examples.rb'

describe Asynchronic::Process, 'Life cycle - Redis' do

  let(:queue_engine) { Asynchronic::QueueEngine::Ost.new }
  let(:data_store) { Asynchronic::DataStore::Redis.new :asynchronic_test }

  include LifeCycleExamples

end