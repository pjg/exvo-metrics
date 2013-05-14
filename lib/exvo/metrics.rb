require 'exvo/metrics/version'
require 'exvo/dummy_metrics'

module Exvo

  class Metrics

    def initialize(user, request)
      @user, @request = user, request
    end

    def identify(user)
      @user = user
      append_identification
    end

    def track(event_name, properties = {})
      append_identification unless identified?
      metrics_platform.append_track(event_name, properties)
    end

    def method_missing(method, *args, &block)
      metrics_platform.public_send(method, *args, &block)
    end

    private

    def metrics_platform
      @metrics_platform ||=
        if defined?(Rails) && Rails.application.config.middleware.include?("Mixpanel::Middleware")
          Mixpanel::Tracker.new(ENV['MIXPANEL_API_TOKEN'], { env: @request.env, persist: true })
        else
          Exvo::DummyMetrics.new
        end
    end

    def identified?
      @identified
    end

    def append_identification
      # identify the user
      metrics_platform.append_identify(@user.nickname)

      # name this user in Stream view
      metrics_platform.append("name_tag", @user.nickname)

      # set properties of this user
      metrics_platform.append_set(user_properties)

      mark_as_identified
    end

    def user_properties
      {
        id: @user.id,
        email: @user.email,
        first_name: @user.first_name,
        last_name: @user.last_name,
        username: @user.nickname,
        theme: @user.theme,
        country_code: @user.country_code,
        created: @user.created_at
      }
    end

    def mark_as_identified
      @identified = true
    end

  end

end
