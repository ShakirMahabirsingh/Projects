rm (list = ls())
library (dplyr)
library (ggplot2)

COVID.Initial.Data = read.csv ("C:\\Users\\shaki\\Desktop\\\\3920 Project\\current-data-on-the-geographic-distribution-of-covid-19-cases-worldwide.csv", header = T )

Covid.Data = COVID.Initial.Data %>% select (c( -8, -9))
Covid.Data = na.omit (Covid.Data %>% arrange (year, month, day))
str (Covid.Data)
summary (Covid.Data)
## Cases : Mean = 132.4   Deaths : Mean = 7.258    Pop : Mean = 65 Mil 

names (Covid.Data)
head (Covid.Data)

###################### Choosing the Better Prediction Model


mdl = lm (deaths ~ cases + popdata2018, data = Covid.Data)
mdl2 = lm (deaths ~ popdata2018, data = Covid.Data)

summary (mdl)
summary (mdl2)

##mdl is the better prediction model, better R-Squared

######################  Linear Regressions 

lin.reg.test = lm (deaths ~ cases + popdata2018, data = Covid.Data)
summary (lin.reg.test)
## Initial Lin Reg of the Covid Data

coef (lin.reg.test)
#For every one unit change in Cases, Deaths will increase by 0.04507761
#For every one unit change in PopData2018, Deaths will increase by -0.000000005880054 (inverse relationship)


###################### Graphs of Initial Covid Data - Follows assumptions 


ggplot (Covid.Data, aes (x = cases, y = deaths)) + 
  geom_point () + 
  geom_smooth (method = "lm") +
  xlab ("Cases") + ylab ("Deaths") + ggtitle ("Global Covid Deaths Given Cases")
#Scatterplot of Deaths / Cases with Trend Line 


###################### Prediction 

x = Covid.Data$cases
y = Covid.Data$deaths
mdl1 = lm (y~x + Covid.Data$popdata2018)

pred.w.plim = predict (mdl1, interval = "prediction")
pred.w.clim = predict (mdl1, interval = "confidence")

pred.frame = data.frame (x)
class (x)
pp = predict (mdl1, int = "p", newdata = pred.frame)
pc = predict (mdl1, int = "c", newdata = pred.frame)
plot (x, y , ylim = range (y, pp), xlab = "cases", ylab = "deaths")
pred = pred.frame$x
matlines (pred, pc, lty = c (1, 2, 2), col = "blue")
matlines (pred, pp, kty = c(1, 3, 3), col = "red")

#More cases will lead to more deaths in the coming months 
#Lines indicate our confidence intervals, data will stay within those bounds


###################### Total Cases & Deaths in the 4 Countries 

US.casesdata = Covid.Data %>% filter (countriesandterritories == "United_States_of_America") %>%
  select (cases)
Total.USCases = sum (US.casesdata)

US.deathdata = Covid.Data %>% filter (countriesandterritories == "United_States_of_America") %>%
  select (deaths)
Total.USdeaths = sum (US.deathdata)
Total.USCases ; Total.USdeaths

#The US has 312,237 total cases & 8,501 total deaths


India.casesdata = Covid.Data %>% filter (countriesandterritories == "India") %>%
  select (cases)
Total.IndiaCases = sum (India.casesdata)

India.deathdata = Covid.Data %>% filter (countriesandterritories == "India") %>%
  select (deaths)
Total.Indiadeaths = sum (India.deathdata)
Total.IndiaCases ; Total.Indiadeaths

#India has 3,374 total cases & 77 total deaths 


Italy.casesdata = Covid.Data %>% filter (countriesandterritories == "Italy") %>%
  select (cases)
Total.ItalyCases = sum (Italy.casesdata)

Italy.deathdata = Covid.Data %>% filter (countriesandterritories == "Italy") %>%
  select (deaths)
Total.Italydeaths = sum (Italy.deathdata)

Total.ItalyCases ; Total.Italydeaths

#Italy has 124,632 total cases & 15,362 total deaths 


Spain.casesdata = Covid.Data %>% filter (countriesandterritories == "Spain") %>%
  select (cases)
Total.SpainCases = sum (Spain.casesdata)


Spain.deathdata = Covid.Data %>% filter (countriesandterritories == "Spain") %>%
  select (deaths)
Total.Spaindeaths = sum (Spain.deathdata)
Total.SpainCases ; Total.Spaindeaths

#Spain has 124,736 total cases & 11,744 total deaths 

Total.WorldCases = sum (Covid.Data$cases)
Total.Worlddeaths = sum (Covid.Data$deaths)

UsvsWorld =  (Total.USCases / Total.WorldCases) *100
IndiavsWorld = (Total.IndiaCases / Total.WorldCases) *100
ItalyvsWorld = (Total.ItalyCases / Total.WorldCases) *100
SpainvsWorld = (Total.SpainCases / Total.WorldCases) *100
UsvsWorld ; IndiavsWorld ; ItalyvsWorld ; SpainvsWorld


UsvsWorld.d =  (Total.USdeaths / Total.Worlddeaths) *100
IndiavsWorld.d = (Total.Indiadeaths / Total.Worlddeaths) *100
ItalyvsWorld.d = (Total.Italydeaths / Total.Worlddeaths) *100
SpainvsWorld.d = (Total.Spaindeaths / Total.Worlddeaths) *100
UsvsWorld.d ; IndiavsWorld.d ; ItalyvsWorld.d ; SpainvsWorld.d


top4.d.table = data.frame ("Countries" = c("US", "India", "Italy", "Spain"), "Deaths" = c(Total.USdeaths, Total.Indiadeaths, Total.Italydeaths, Total.Spaindeaths))
top4.d.table

world.c.table = data.frame ("Countries" = c("US", "India", "Italy", "Spain"), "% of World's Cases" = c(UsvsWorld, IndiavsWorld, ItalyvsWorld, SpainvsWorld))
world.c.table

world.d.table = data.frame ("Countries" = c("US", "India", "Italy", "Spain"), "% of World's Deaths" = c(UsvsWorld.d, IndiavsWorld.d, ItalyvsWorld.d, SpainvsWorld.d))
world.d.table

#The US has 26% of the World's Total Cases, India has 0.28%, Italy has 10.61%, and Spain has 10.61%
#The US has 13.2% of the World's total deaths, India has 0.11%, Italy has 23.85%, Spain has 18.23%

#While the US leads the world in infection rates (given cases) in these 4 countries, Italy has the higher mortality rate 

###################### Bar Plots

ggplot (top4.d.table, aes (x = Countries, y = Deaths, fill = Countries)) + 
  geom_bar (colour = "black", stat = "identity") +
  ylab ("Deaths") + ggtitle ("Death Totals")


###################### Scatterplot Graphs 

######################### US 

US.c.time = data.frame (COVID.Initial.Data %>% filter (countriesandterritories == "United_States_of_America") %>% select (c(-8, -9)) %>% arrange (year, month, day))
US.c.time = US.c.time [-c(1),]
ggplot (US.c.time, aes (x= cases, y = deaths )) + 
  geom_point (colour = "red", size = 1.5) + 
  xlab ("Cases") + ylab ("Deaths") + ggtitle ("US Deaths to Cases Past 4 Months") 

US.c.time$daterep = as.Date (US.c.time$daterep, format = "%Y-%m-%d")
class (US.c.time$daterep)

ggplot (US.c.time, aes (x = daterep, y = deaths )) + 
  geom_point (colour = "red", size = 1.5) + 
  xlab ("Every 15 Days") + ylab ("Deaths") + 
  scale_x_date (date_breaks = "15 days") +
  ylim (NA, 1200) +
  ggtitle ("US Deaths Past 4 Months")

######################### India

India.c.time = COVID.Initial.Data %>% filter (countriesandterritories == "India") %>% select (c(-8, -9)) %>% arrange (year, month, day)
India.c.time = India.c.time [-c(1),]
India.c.time$daterep = as.Date (India.c.time$daterep, format = "%Y-%m-%d")
class (India.c.time$daterep)


ggplot (India.c.time, aes (x= cases, y = deaths )) + 
  geom_point (colour = "red", size = 1.5) + 
  xlab ("Cases") + ylab ("Deaths") + 
  ggtitle ("India Deaths to Cases Past 4 Months") 

ggplot (India.c.time, aes (x = daterep, y = deaths )) + 
  geom_point (colour = "red", size = 1.5) + 
  xlab ("Every 15 Days") + ylab ("Deaths") + 
  scale_x_date (date_breaks = "15 days") + ylim (NA, 30) + 
  ggtitle ("India Deaths Past 4 Months") 

######################### Italy

Italy.c.time = COVID.Initial.Data %>% filter (countriesandterritories == "Italy") %>% select (c(-8, -9)) %>% arrange (year, month, day)
Italy.c.time = Italy.c.time [-c(1),]
Italy.c.time$daterep = as.Date (Italy.c.time$daterep, format = "%Y-%m-%d")
class (Italy.c.time$daterep)


ggplot (Italy.c.time, aes (x= cases, y = deaths )) + 
  geom_point (colour = "red", size = 1.5) + 
  xlab ("Cases") + ylab ("Deaths") + ggtitle ("Italy Deaths to Cases Past 4 Months") 

ggplot (Italy.c.time, aes (x = daterep, y = deaths )) + 
  geom_point (colour = "red", size = 1.5) +
  scale_x_date (date_breaks = "15 days") + ylim (NA, 1200) + 
  xlab ("Every 15 Days") + ylab ("Deaths") + ggtitle ("Italy Deaths Past 4 Months") 

######################### Spain

Spain.c.time = COVID.Initial.Data %>% filter (countriesandterritories == "Spain") %>% select (c(-8, -9)) %>% arrange (year, month, day)
Spain.c.time = Spain.c.time [-c(1),]
Spain.c.time$daterep = as.Date (Spain.c.time$daterep, format = "%Y-%m-%d")
class (Spain.c.time$daterep)

ggplot (Spain.c.time, aes (x= cases, y = deaths )) + 
  geom_point (colour = "red", size = 1.5) + 
  xlab ("Cases") + ylab ("Deaths") + ggtitle ("Spain Deaths to Cases Past 4 Months") 

ggplot (Spain.c.time, aes (x = daterep, y = deaths )) + 
  geom_point (colour = "red", size = 1.5) +
  scale_x_date (date_breaks = "15 days") + ylim (NA, 1200) + 
  xlab ("Every 15 Days") + ylab ("Deaths") + ggtitle ("Spain Deaths Past 4 Months") 

