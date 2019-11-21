
library(lubridate)
library(sqldf)
setwd("C:\\Weber State University\\MATH 4400 Big & Small Data - Julian Chan\\Final Project")
basedata = read.csv("training.csv")

  
  basedata = basedata[which(basedata$agentSeconds>0),]
  basedata$time<-ymd_hms(basedata$contactStart, tz = "America/Denver")
  basedata$timerounded<-floor_date(basedata$time, unit = "hour")
  basedata$minute<-round(as.numeric(basedata$agentSeconds)/60)
  basedata$minute
  
  hours = format(as.POSIXct(strptime(basedata$timerounded, "%Y-%m-%d %H:%M:%S", tz = "")), format = "%H:%M:%S")
  dates = format(as.POSIXct(strptime(basedata$timerounded, "%Y-%m-%d %H:%M:%S", tz = "")), format = "%Y-%m-%d")
  
  basedata$hour = hours
  basedata$date = dates
  
  handleTimes<-sqldf("SELECT date, hour, AVG(agentSeconds) as HandleTime FROM basedata WHERE hour NOT BETWEEN '08:00:00' AND '10:00:00' AND hour NOT LIKE '12:00:00'
              AND hour NOT LIKE '15:00:00' AND hour NOT BETWEEN '18:00:00' AND '19:00:00' GROUP BY date, hour")
  handleTimes
  
  callVolumes<-sqldf("SELECT date, hour, COUNT(timerounded) as calls FROM basedata WHERE hour NOT BETWEEN '08:00:00' AND '10:00:00' AND hour NOT LIKE '12:00:00'
              AND hour NOT LIKE '15:00:00' AND hour NOT BETWEEN '18:00:00' AND '19:00:00' GROUP BY date, hour")
  callVolumes
  
  minutes<-sqldf("SELECT date, hour, ROUND(AVG(minute)) as HandleTime_minute FROM basedata WHERE hour NOT BETWEEN '08:00:00' AND '10:00:00' AND hour NOT LIKE '12:00:00'
              AND hour NOT LIKE '15:00:00' AND hour NOT BETWEEN '18:00:00' AND '19:00:00' GROUP BY date, hour")
  minutes
  
  #P.S: All of the data of the handletimes and callvolumes are came out. The hour have been already fixed all based on .csv files.
  # if come out other hour time from .csv file, like 02:00:00, 06:00:00, 20:00:00, 21:00:00, etc, are going to '0'.
  


