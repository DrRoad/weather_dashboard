The dashboard is hosted here: https://darren-keeley.shinyapps.io/weather-dashboard/

Or you can run it locally, as detailed below.

# How to run Weather Dashboard
1. Install the following packages:
`shiny
shinyWidgets
tidyverse
plotly
zoo
lubridate
flexdashboard`

2. Open weather dashboard.rdm and click "Run Document" near the top left of the document.

3. On the window that pops up, click "Open in Browser" on the top left.

Warning: if your display's resolution isn't 1920x1080, then the dashboard won't display perfectly. My apologies, I haven't figured out a way to automatically resize the dashboard according to the user's display resolution.

# What is this Weather Dashboard?
The weather dashboard analyzes the accuracy of weather forecasts regarding temperature and precipitation. The data is from the Data Expo 2018, and it includes Historical data (the actual temperatures and amount of rainfall) and Forecast data (predicted temperatures and chance of rain). More info can be found [here](http://community.amstat.org/stat-computing/data-expo/data-expo-2018).

The dashboard includes 4 plots across 2 pages. The first page is about average monthly mininum and maximum temperatures. The map displays the accuracy of temperature forecasts by city. The slider on the left changes the month and year. Mean Absolute Error is used to measure the forecast accuracy. The line plot shows the predicted and actual min/max temperatures for the year, so that the trend can be analyzed for the entire year.

The second page is the same, only regarding precipitation. The rain data necessitates some explanation. The forecast data included Probability of Precipitation. Since the forecast data was retrieved from the National Weather Service, their definition of Probability of Precipitation was used: the probability that on a particular day, there will be 0.01 inches of rain or more. However, the historical data included the amount of rainfall in inches by day. To connect it with the Forecast's Probability of Precipitation, this "inches of rainfall" variable was converted to a boolean: 0 inches is False, and anything more is True. Then the proportion of rainy days for each month was calculated. Therefore, Average Probability of Precipitation by Month was compared to Proportion of Rainy Days by Month.

The map displays the error of forecasts, explicitly Avg Prob of Precipitation - Proportion of Rainy Days. Positive numbers mean there was more rain than predicted, and negatives numbers mean less. The plot on the right shows the Avg Prob of Precipitation and Proportion of Rainy Days for the year.
