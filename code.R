require(rCharts)

courtPlot <- rCharts$new()
courtPlot$setLib( "." )
courtPlot$setTemplate(
  chartDiv = "<div></div>"
)
courtPlot$setTemplate(
  afterScript = "<script></script>"
)

#some random percentage type data
courtPlot$set(
  data = data.frame(
    region = LETTERS[1:23],
    pct = runif(23, 0, 0.8)
  ),
  y = "pct",
  colors = RColorBrewer::brewer.pal(n=8,"PRGn")
)
courtPlot


courtPlot$save("index.html",cdn=T)
