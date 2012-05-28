module Railsyard
  module Analytics
    class Engine < ::Rails::Engine
      config.to_prepare do
        puts "PREPARED"
        Railsyard::Backend.plugin_manager.add_plugin(:railsyard_analytics) do
          name "Railsyard Analytics"
          backend_javascript_dependency "https://www.google.com/jsapi"
          backend_javascript_dependency "railsyard/analytics"
          dashboard_widget :analytics_line_chart, cell: :railsyard_analytics, action: :line_chart
          dashboard_widget :analytics_pie_chart, cell: :railsyard_analytics, action: :pie_chart
        end
      end
    end
  end
end
