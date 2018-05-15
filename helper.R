band_plot <- function(data, subtitle1, subtitle2) {
  p <- plot_ly(x = data$month, y = data$MaxTemp,
          hoverinfo = 'text', text = ~paste(data$MaxTemp, ",", month.name[data$month]),
          name = "Historical Max Temp",
          type = 'scatter', mode = 'lines', 
          line = list(color = 'rgb(77,175,74)', width = 2),
          opacity = .5) %>% 
    add_trace(y = data$MaxTemp_forecast, 
              hoverinfo = 'text', text = ~paste(data$MaxTemp_forecast, ",", month.name[data$month]),
              line = list(color = 'rgb(152,78,163)', width = 2, dash = 'dash'),
              name = "Forecasted Max Temp") %>% 
    add_trace(y = data$MinTemp,
              hoverinfo = 'text', text = ~paste(data$MinTemp, ",", month.name[data$month]),
              line = list(color = 'rgb(77,175,74)', width = 2),
              name = "Historical Min Temp") %>% 
    add_trace(y = data$MinTemp_forecast,
              hoverinfo = 'text', text = ~paste(data$MinTemp_forecast, ",", month.name[data$month]),
              line = list(color = 'rgb(152,78,163)', width = 2, dash = 'dash'),
              name = "Forecasted Max Temp") %>% 
    layout(xaxis = list(range=c(1,12)), yaxis = list(range=c(-7,113)),
           title = paste("Temperature by Month in", subtitle1, year(as.yearmon(subtitle2))),
           legend = list(x = 0.4, y = 0.08),
           autosize = F, width = 450, height = 650, margin = list(
             l = 30,
             r = 15,
             b = 50,
             t = 50,
             pad = 1
         )
    )
  p
}



band_plot_rain <- function(data, subtitle1, subtitle2) {
  p <- plot_ly(x = data$month, y = data$PropRain,
               hoverinfo = 'text', text = ~paste(data$PropRain, ",", month.name[data$month]),
               name = "% Days of Rain",
               type = 'scatter', mode = 'lines', 
               line = list(color = 'rgb(0,0,153)', width = 2),
               opacity = .5) %>% 
    add_trace(y = data$ProbPrecip, 
              hoverinfo = 'text', text = ~paste(data$ProbPrecip, ",", month.name[data$month]),
              line = list(color = 'rgb(0,255,255)', width = 2, dash = 'dash'),
              name = "Forecasted Chance of Rain") %>% 
    layout(xaxis = list(range=c(1, 12)), yaxis = list(range=c(0, 100)),
           title = paste("% of Days of Rain by Month in", subtitle1, year(as.yearmon(subtitle2))),
           legend = list(x = 0.1, y = 0.85),
           autosize = F, width = 450, height = 650, margin = list(
             l = 30,
             r = 15,
             b = 50,
             t = 50,
             pad = 1
           )
    )
  p
}