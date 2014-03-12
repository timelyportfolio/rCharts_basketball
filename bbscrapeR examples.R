#play with @cpsievert bbscrapeR

#require(devtools)
#install_github("bbscrapeR","cpsievert")
require(bbscrapeR)
data(codes)
#just get a sample game code
game <- tail(codes,1)

shotchart <- rebound(
  strsplit(game,"/")[[1]][2],  #supply date in YYYYMMDD format for begin
  strsplit(game,"/")[[1]][2]   #supply date in YYYYMMDD format for end
)

#we have four games from this one date
shotchart$shotchart_game

#better labels for team
shotchart$shotchart_event$tm <- factor(
  shotchart$shotchart_event$tm,
  labels = c( "Home", "Visitor" )
)

shotchart$shotchart_event$url <- factor(
  shotchart$shotchart_event$url,
  labels = shotchart$shotchart_game$gcd
)


require(lattice)
hexbinplot(y~x|url + tm, data = shotchart$shotchart_event)


require(ggplot2)
g <- ggplot(shotchart$shotchart_event, aes(x,y))
g + stat_binhex()  # for all the games
g + stat_binhex() + facet_grid(tm~url)
