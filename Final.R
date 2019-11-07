install.packages('lubridate')
install.packages('sqldf')
library(lubridate)
library(sqldf)
setwd("C:\\Weber State University\\MATH 4400 Big & Small Data - Julian Chan\\Fiinal Project")
basedata = read.csv("training.csv")

# ymd_hms: Parse data-times with year, month, and day, hour, minute, and second components.
basedata$time=ymd_hms(basedata$contactStart, tz = "America/Denver")
# floor_date: Round, floor and ceiling methods for date-time objects.
basedata$timerounded=floor_date(basedata$time, unit = "30 min")
head(basedata)#Checking

#I'm better in SQL than R so I cheated
summary_totalCalls<-sqldf('SELECT timerounded, COUNT(timerounded) as Totalcalls FROM basedata GROUP BY timerounded')
summary_totalCalls
summary_averageAgentSeconds = sqldf('SELECT timerounded, AVG(agentSeconds) as avgAgentSeconds FROM basedata GROUP BY timerounded')
summary_averageAgentSeconds
basedata$dow = wday(basedata$timerounded, label = TRUE)   #dow: days of the week
basedata$week = isoweek(basedata$timerounded)
names(basedata)
summary = sqldf('SELECT timerounded, dow, week, AVG(agentSeconds) as avgAgentSeconds, COUNT(timerounded) as calls FROM basedata GROUP BY timerounded, dow, week')
summary
df <- data.frame(summary)
head(df)
  df$dayOfWeek = sqldf('SELECT timerounded, AVG(agentSeconds) as avgAgentSeconds, COUNT(timerounded) as calls FROM basedata GROUP BY timerounded')
#summary = sqldf('SELECT timerounded, AVG(agentSeconds)/COUNT(timerounded) as averageTime FROM basedata GROUP BY timerounded')
#summary
head(basedata)
head(df)
attach(df)

boxplot(df$avgAgentSeconds ~ df$dow)
boxplot(df$calls ~ df$dow)


wday(timerounded, label = TRUE)#weekday
hour(timerounded)#hour
minute(timerounded)#minute


#https://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html


