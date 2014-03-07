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
    pct = runif(23, 0.2, 0.7)
  ),
  y = "pct",
  colors = RColorBrewer::brewer.pal(n=8,"PuBu")
)
courtPlot
