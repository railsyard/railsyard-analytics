# Google Analytics widgets for Railsyard Dashboard

### Install

Simply add `gem 'railsyard-analytics'` to your `Gemfile` and run `bundle install`

### Usage

```
Railsyard::Backend.define_dashboard do

  column do

    widget :analytics_line_chart, :last_week_visits do
      username "your@credentials.com"
      password "password"
      profile "analytics_profile_name"
      start_date -> { 7.days.ago }
      end_date -> { Date.today }
      metrics [ :visits, :visitors, :pageviews ]
    end

    widget :analytics_pie_chart, :returning_visitors do
      username "your@credentials.com"
      password "password"
      profile "analytics_profile_name"
      start_date -> { 7.days.ago }
      end_date -> { Date.today }
      dimension :visitor_type
      metric :pageviews
      sort :pageviews.desc
    end

  end

end
```

### Testing

* clone this repo
* run `bundle install`
* run `rspec spec`

## Contributions & Bugs

* *the easy way:* go to [issues](issues/) page and blame me.
* *the hard way:* repeat the above points, then show your power and send a pull request.
