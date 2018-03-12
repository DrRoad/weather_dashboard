scl = list(list(0, "rgb(0, 0, 255)"), list(0.25, "rgb(0, 255, 0)"),
           list(0.50, "rgb(255, 255, 0)"), list(1, "rgb(255, 0, 0)"))


scl_rain = list(list(0, "rgb(255, 128, 0)"), list(0.33, "rgb(255, 255, 255)"), 
                list(.5, "rgb(0, 255, 255)"), list(1, "rgb(0, 0, 153)"))


# change default color scale title
m <- list(colorbar = list(title = ""))

# geo styling
g <- list(
  scope = 'north america',
  showland = TRUE,
  landcolor = toRGB("grey83"),
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white"),
  showlakes = TRUE,
  lakecolor = toRGB("white"),
  showsubunits = TRUE,
  showcountries = TRUE,
  resolution = 50,
  projection = list(
    type = 'conic conformal',
    rotation = list(lon = -100)
  ),
  lonaxis = list(
    showgrid = TRUE,
    gridwidth = 0.5,
    range = c(-120, -65),
    dtick = 5
  ),
  lataxis = list(
    showgrid = TRUE,
    gridwidth = 0.5,
    range = c(25, 50),
    dtick = 5
  )
)

weather_map <- function(data, subtitle) {
  p <- plot_geo(data) %>%
    add_markers(y = ~lat, x = ~long,
                text = ~paste(city, ",", Avg_mae),
                mode = "markers", type = "scatter",
                marker = list(color = ~Avg_mae,
                              colorscale = scl,
                              cauto = FALSE,
                              colorbar = list(title="", thickness = 10, len = .6),
                              cmax = 11,
                              cmin = 1,
                              size = 10)
    ) %>%
    layout(title = paste('Average MAE of Forecasts for', subtitle), geo = g)
  p
}

weather_map_rain <- function(data, subtitle) {
  p <- plot_geo(data) %>%
    add_markers(y = ~lat, x = ~long,
                text = ~paste(city, ",", RainError),
                mode = "markers", type = "scatter",
                marker = list(color = ~RainError,
                              colorscale = scl_rain,
                              cauto = FALSE,
                              colorbar = list(title="", thickness = 10, len = .6),
                              cmax = 100,
                              cmin = -50,
                              size = 10)
    ) %>%
    layout(title = paste('PropRain - ProbPrecip of Forecasts for', subtitle), geo = g)
  p
}











band_plot <- function(data, subtitle1, subtitle2) {
  p <- plot_ly(x = data$month, y = data$MaxTemp,
          hoverinfo = 'text', text = ~paste(data$MaxTemp, ",", month.name[data$month]),
          name = "Historical Max Temp",
          type = 'scatter', mode = 'lines', 
          line = list(color = 'rgb(77,175,74)', width = 2),
          opacity = .5, width = 800) %>% 
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
         legend = list(x = 0.4, y = 0.08)
         )
  p
}



band_plot_rain <- function(data, subtitle1, subtitle2) {
  p <- plot_ly(x = data$month, y = data$PropRain,
               hoverinfo = 'text', text = ~paste(data$PropRain, ",", month.name[data$month]),
               name = "% Days of Rain",
               type = 'scatter', mode = 'lines', 
               line = list(color = 'rgb(0,0,153)', width = 2),
               opacity = .5, width = 800) %>% 
    add_trace(y = data$ProbPrecip, 
              hoverinfo = 'text', text = ~paste(data$ProbPrecip, ",", month.name[data$month]),
              line = list(color = 'rgb(0,255,255)', width = 2, dash = 'dash'),
              name = "Forecasted Chance of Rain") %>% 
    layout(xaxis = list(range=c(1,12)), yaxis = list(range=c(0,100)),
           title = paste("Percent of Days of Rain by Month in", subtitle1, year(as.yearmon(subtitle2))),
           legend = list(x = 0.7, y = 0.9)
    )
  p
}