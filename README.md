# Exvo::Metrics

Wrapper class/gem for the Mixpanel metrics system. It is configured to be used together with the `Mixpanel::Middleware` Rack middleware so that the tracking requests are sent asynchronously via client-side Javascript to the Mixpanel site.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exvo-metrics'
```


Then execute:

```bash
$ bundle
```


In your `ApplicationController`:

```ruby
def metrics
  @metrics ||= Exvo::Metrics.new(current_user, request)
end
```


In `config/environments/production.rb`:

```ruby
config.middleware.use "Mixpanel::Middleware", ENV['MIXPANEL_API_TOKEN'], { persist: true }
```

You can also add the above line to any environemnt you want (staging, development, etc.).

Remember to set the `ENV['MIXPANEL_API_TOKEN']` as well!



## Usage

Add the following tracking code in one of your controllers:

```ruby
 metrics.track 'Profile update'
```


You can also pass some custom params, which will be visible in the Mixpanel dashboard:

```ruby
 metrics.track 'Profile update', Type: 'Normal flow'
```


If there is a situation, where `current_user` might be nil (as is the case during sign up process), you ca explicitly identify such user after you have a user record created in the database:

```ruby
 metrics.identify(user)
 metrics.track 'Sign un'
```



## Caveats

Since the actual tracking is happening via client-side javascript calls, there might be a situation, when you track something in the controller, but after that there is a redirect to another website. In such situation the metric might not be recorded properly (it is usually the case with Exvo-Auth and signing in).

If, however, during the same browser session the user visits the app which did the redirect (i.e. Exvo-Auth), the stored event ('Signing in') will be sent to Mixpanel. After browser restart it is lost.



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



Copyright © 2013 Exvo.com Development BV, released under the MIT license
