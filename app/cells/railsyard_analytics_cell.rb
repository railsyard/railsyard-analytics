class RailsyardAnalyticsCell < Cell::Rails

  cache :line_chart, :expires_in => 10.minutes
  cache :pie_chart, :expires_in => 10.minutes

  def line_chart(settings)
    settings = settings.to_hash.reverse_merge(
      start_date: Proc.new { 30.days.ago },
      end_date: Proc.new { Date.today },
      metrics: :visits,
      height: 400
    )

    metrics = settings[:metrics].is_a?(Array) ? settings[:metrics] : [ settings[:metrics] ]

    Garb::Session.login(settings[:username], settings[:password])
    profile = Garb::Management::Profile.all.find { |p| p.title = settings[:profile] }

    report_class = Class.new
    report_class.extend Garb::Model
    report_class.metrics(metrics)
    report_class.dimensions(:date)

    @results = report_class.results(profile, start_date: settings[:start_date].call, end_date: settings[:end_date].call).map do |row|
      result = []
      result << Date.strptime(row.date, '%Y%m%d')
      metrics.each do |metric|
        result << row.send(metric).to_f
      end
      result
    end

    @metric_labels = metrics.map do |metric|
      I18n.t("railsyard.analytics.metrics.#{metric}", default: metric.to_s.titleize)
    end

    @chart_height = settings[:height]

    render
  end

  def pie_chart(settings)
    settings = settings.to_hash.reverse_merge(
      start_date: Proc.new { 30.days.ago },
      end_date: Proc.new { Date.today },
      height: 400,
      limit: 10
    )

    Garb::Session.login(settings[:username], settings[:password])
    profile = Garb::Management::Profile.all.find { |p| p.title = settings[:profile] }

    metric = settings[:metric]
    dimension = settings[:dimension]

    report_class = Class.new
    report_class.extend Garb::Model
    report_class.metrics(metric)
    report_class.dimensions(dimension)

    @results = report_class.results(
      profile,
      start_date: settings[:start_date].call,
      end_date: settings[:end_date].call,
      limit: settings[:limit],
      sort: settings[:sort]
    ).map do |row|
      result = []
      result << row.send(dimension)
      result << row.send(metric).to_f
      result
    end

    @metric_label= I18n.t("railsyard.analytics.metrics.#{metric}", default: metric.to_s.titleize)
    @chart_height = settings[:height]

    render
  end

end
