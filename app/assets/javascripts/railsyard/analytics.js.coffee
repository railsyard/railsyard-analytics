google.load "visualization", "1", packages: [ "corechart" ]
google.setOnLoadCallback ->
  $ ->

    $("[data-analytics-chart-type='pie']").each ->
      $widget = $(@)

      dataTable = new google.visualization.DataTable()

      dataTable.addColumn('string', 'Metric')
      dataTable.addColumn('number', 'Dimension')

      for row in $widget.data("series")
        dataTable.addRow row

      chart = new google.visualization.PieChart($widget.get(0))
      chart.draw(
        new google.visualization.DataView(dataTable)
        height: $widget.data("height")
      )

    $("[data-analytics-chart-type='line']").each ->
      $widget = $(@)

      dataTable = new google.visualization.DataTable()

      dataTable.addColumn('date', 'Date')
      for label in $widget.data("labels")
        console.log label
        dataTable.addColumn "number", label

      for row in $widget.data("series")
        row[0] = new Date(Date.parse(row[0]))
        dataTable.addRow row

      chart = new google.visualization.LineChart($widget.get(0))
      chart.draw(
        new google.visualization.DataView(dataTable)
        pointSize: 5
        height: $widget.data("height")
        hAxis:
          format: 'd MMM'
      )
