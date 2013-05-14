require 'spec_helper'

describe Exvo::DummyMetrics do

  let(:dummy) { Exvo::DummyMetrics.new }

  it 'responds true to any method' do
    dummy.track('Sign up').should be_true
  end

  it 'responds true to any method with any params' do
    dummy.track('Sign up', Type: 'via Facebook').should be_true
  end

end
