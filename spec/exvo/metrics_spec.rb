require 'spec_helper'

describe Exvo::Metrics do

  let(:user) { OpenStruct.new({ nickname: 'Pawel' }) }
  let(:request) { OpenStruct.new(env: { RAILS_ENV: 'test' }) }

  let(:metrics) { Exvo::Metrics.new(user, request) }
  let(:metrics_platform) { double }

  before do
    Exvo::Metrics.any_instance.stub(:metrics_platform) { metrics_platform }
  end

  describe '#identify' do

    it 'identifies the user in the metrics platform' do
      metrics_platform.should_receive(:append_identify).with(user.nickname)
      metrics_platform.should_receive(:append).with('name_tag', user.nickname)
      metrics_platform.should_receive(:append_set)
      metrics.identify(user)

      metrics.should be_identified
    end

  end

  describe '#track' do

    before do
      metrics.stub(:identified?) { true }
    end

    it 'send tracking request' do
      metrics_platform.should_receive(:append_track)
      metrics.track('Sign in')
    end

  end

  it 'forwards all other methods to the metrics platform' do
    metrics_platform.should_receive(:set_once).with('id')
    metrics.set_once('id')
  end

end
