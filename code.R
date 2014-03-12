require(rCharts)

courtPlot <- rCharts$new()
courtPlot$setLib( 
  "."
  #http://timelyportfolio.github.io/rCharts_basketball
)
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


#courtPlot$save("index.html",cdn=T)


### now using techniques from rmaps
### see post http://rmaps.github.io/blog/posts/animated-choropleths/index.html
### quickly demo angular controls with a courtPlot
courtPlot2 <- rCharts$new()
courtPlot2$setLib(
  "."
  #http://timelyportfolio.github.io/rCharts_basketball
)
courtPlot2$set(
  data = data.frame(
    year = unlist(lapply(2010:2013,rep,23)),
    region = rep(LETTERS[1:23],4),
    pct = runif(23 * 4, 0, 0.8)
  ),
  y = "pct",
  colors = RColorBrewer::brewer.pal(n=8,"RdBu")
)
courtPlot2$templates$script = 
  "./layouts/chart_angular.html"
  #"http://timelyportfolio.github.io/rCharts_basketball/layouts/chart_angular.html"
courtPlot2$set(
  bodyattrs = "ng-app ng-controller='rChartsCtrl'"
)
courtPlot2$addAssets(
  jshead = "http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.2.1/angular.min.js"
)
courtPlot2$setTemplate(chartDiv = "
  <div class='container'>
    <input id='slider' type='range' min=2010 max=2013 ng-model='year' width=200>
    <span ng-bind='year'></span>
  </div>

  <script>
  function rChartsCtrl($scope){
    $scope.year = 2013;
    $scope.$watch('year', function(newYear){
      drawChart(
        d3.nest().key(function(d){
          return d[0]
        }).map(d3.zip.apply(this,d3.values(params.data)))[newYear]
      );
    })
  }
  </script>
"
)
courtPlot2$setTemplate(
  afterScript = "<script></script>"
)
courtPlot2


### do one for simulated players
### now using techniques from rmaps
### see post http://rmaps.github.io/blog/posts/animated-choropleths/index.html
### quickly demo angular controls with a courtPlot
courtPlot3 <- rCharts$new()
courtPlot3$setLib(
  "."
  #http://timelyportfolio.github.io/rCharts_basketball
)
courtPlot3$set(
  data = data.frame(
    player = unlist(lapply(
      c("Michael Jordan","Larry Bird","Kevin Durant","Lebron James"),
        rep,
        23
      )
    ),
    region = rep(LETTERS[1:23],4),
    pct = runif(23 * 4, 0, 0.8)
  ),
  y = "pct",
  colors = RColorBrewer::brewer.pal(n=8,"RdBu")
)
courtPlot3$templates$script = 
  "./layouts/chart_angular.html"
#"http://timelyportfolio.github.io/rCharts_basketball/layouts/chart_angular.html"
courtPlot3$set(
  bodyattrs = "ng-app ng-controller='rChartsCtrl'"
)
courtPlot3$addAssets(
  jshead = "http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.2.1/angular.min.js"
)
courtPlot3$setTemplate(chartDiv = sprintf(
"
 <div class='container'>
    <select ng-model='player' class='form-control'
       ng-options='player for player in %s'>
      {{ player }}
    </select>
 </div>
       
 <script>
 function rChartsCtrl($scope){
    $scope.player = '%s';
    $scope.$watch('player', function(choice){
      drawChart(
        d3.nest().key(function(d){
          return d[0]
        }).map(d3.zip.apply(this,d3.values(params.data)))[choice]
      );
    })
  }
 </script>
  ",
  rjson::toJSON(levels(courtPlot3$params$data$player)),
  levels(courtPlot3$params$data$player)[1]
))
courtPlot3$setTemplate(
  afterScript = "<script></script>"
)
courtPlot3
