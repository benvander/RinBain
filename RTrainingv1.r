## Putting the R in Bain

## Welcome to our session on R! We're excited to learn with you.
## You've already done some of the hard part: you installed the software, and opened this script.
## R is a programming environment. The software has two main windows: the console, and a script editor. 
## The console is where code runs live, line by line. 
## The script editor allows you to write a collection of code to be run all together.
## To run code that is written in the script, select the line and hit "Ctrl+R"

## At the most basic level, R can be used as a fancy calculator. 

5+5

## (Also, on any given line, anything after "#" will not be run, so it's useful for comments!)

## Try writing your own



## The answer will output to the console. Sometimes though, we want to store our answer as a variable. 

x <- 5+5
x
x+5

## Great. The neat thing about variables in R though is that they needn't be simple values!
## These objects can also be vectors.

myVector <- c(1,2,3,4,5)
myVector

yourVector <- c(11:15)
yourVector

textVector <- c("This","is","a","vector","too","!")
textVector

## We can also apply math to these vectors

myVector * 2
myVector + 2
myVector + yourvector # Note that this doesn't work, because R is case-sensitive!
myVector + yourVector

## We also need to learn how to use functions. Functions can be applied to objects, as below:

length(myVector)
sum(myVector)
mean(myVector/2)

## Try finding the median of the sum of myVector and yourVector



## Each function evaluates to a value , so they can be combined or stored as objects themselves. 

myRange <- max(myVector) - min(myVector)
myRange

## We can also refer to specific values within our vector.

yourVector[3]
textVector[2]
(2*myVector)[2]+yourVector[4]
myVector[c(1,3)]

## In addition to vectors, we can also look at tables (called "Data Frames" in R).
## R has several built in, so let's look at one.

mtcars # Results from Motor Trends car testing

## That looks a lot like what you'd be used to in Excel!
## You can easily access different parts of the table.

mtcars[2,3]
mtcars[5,]

## This lets you quickly do a lot of what you might've done in Excel.
## There's also multiple ways you can refer to columns.

sum(mtcars[,1])
median(mtcars[,"hp"])
max(mtcars$gear)
colMeans(mtcars)

## R is also especially great for other quick analysis! Check out this one.

table(mtcars$gear)

## Then, we can quickly turn it into charts!

counts <- table(mtcars$vs, mtcars$gear)
barplot(counts)

## We can make the chart prettier, add labels, etc. just like you would with a Bain chart.

barplot(counts, main="Car Distribution by Gears and VS",xlab="Number of Gears",ylab="Count of Cars",legend=rownames(c("VS","Gears")),ylim=c(0,16))

## And we can make many different types of charts:

plot(mtcars$hp,mtcars$qsec,main="Powerful cars go faster!",xlab="Horsepower",ylab="Time to travel 1/4 mile")

## While we're making a scatterplot, let's try a quick regression

lm(mtcars$qsec~mtcars$hp)

## And add that to our chart

abline(lm(mtcars$qsec~mtcars$hp))

## R can even make Marimekko charts
## Let's make up some data:

?sample
Bar1 <- sample(1:100,5)

?rnorm
Bar2 <- rnorm(5,mean = 50, sd = 25)

?runif
Bar3 <- runif(5,1,100)

sampledata <- cbind(Bar1,Bar2,Bar3)
rownames(sampledata) <- c("Series1","Series2","Series3","Series4","series5")

## So here's our data set to put into a mekko:

sampledata
mosaicplot(t(sampledata), col=c("gray25","gray45","gray65","gray85","gray95"),off=0,main="Great to be able to create charts quickly!")

## Hm. R plots from the top left instead of the bottom left like we would. We would want to reverse the order of the rownames. 
## One of the nice things about R is how insanely Google-able it is for help. Try "reverse vector order r". 
## SO many insanely great resources online. The community is amazing. StackOverflow, QuickR, and others have almost all of the answers. 

rownames(sampledata) <- rev(rownames(sampledata))
mosaicplot(t(sampledata), col=c("gray25","gray45","gray65","gray85","gray95"),off=0,main="Thanks, Internet!!")

## You now know enough about R to get started playing around!

##############################################################

## Let's try a few examples more similar to case work. The in this case, a retail client gave us several of their data files.

## To do that, we'll need to load in external data. You saved it from the email earlier.
## Select the console, then go to File -> Change dir and navigate to where you saved that.

## I'm reading in data that's hosted online! It takes a while to load because it's downloading it, not because it's slow to process.
## Then, you can read in the data as below:

setwd()
Transactions <- read.csv("SampleTransactionData.csv")
CustInfo <- read.csv("SampleCustInfo.csv")
StoresList <- read.csv("Stores_Rollout.csv")
SurveyData <- read.csv("SampleSurveyData.csv")

## Let's browse the data. First, transactions.

DataDimensions <- rbind(dim(Transactions),dim(CustInfo),dim(StoresList),dim(SurveyData)); colnames(DataDimensions) <- c("Number of Rows","Number of Columns"); rownames(DataDimensions) <- c("Transactions","CustInfo","StoresList","SurveyData")
DataDimensions

Transactions[1:10,]
CustInfo[1:10,]
StoresList[1:10,]
SurveyData[1:10,]

## Cool. First, let's add a total spent to each row of our customer dataset. 

AmountSpent <- aggregate(Transactions$TransactionAmount~Transactions$TransactionCusts,FUN=sum)
AmountSpent[1:10,]
colnames(AmountSpent) <- c("IDs","AmountSpent")
CustInfo <- merge(CustInfo,AmountSpent,by = "IDs",all.x=TRUE)

## Easy. Now let's see if there's a difference in store incomes where they have the new POS systems installed.

TotalNew <- StoresList[StoresList[,"POSInstalled"]=="Installed","TransactionTotal"]
TotalOld <- subset(StoresList,POSInstalled=="Old-school")[,"TransactionTotal"]
t.test(TotalNew,TotalOld)

## What about if there's a connection between POS system and ownership status?

table(StoresList$POSInstalled,StoresList$OwnershipStatus)

## Cool! Looks like a relationship. Looks like something that'd be easy to turn into a slide, or we can make a quick visual of the chart here.

mosaicplot(t(table(StoresList$POSInstalled,StoresList$OwnershipStatus)),main="The owned stores haven't moved to the new POS system",col=c("red","gray50"),off=0)

## Now you try!

## 1) What is the median total transaction volume from stores in California?



## 2) How do gender (M=1, F=2), marital status, and age impact customer spending?



## 3) How is NPS score related to customer demographics? Is NPS related to liklihood of returning?



##############################################################

## Awesome. Let's look at another examples, this time of something I did for my case last week! 

## This is something I did on a case last week
## our client owns a portfolio of 7 companies, and they gave us forecasts for future profits for each of them. 
## We want to simulate the outcomes for the total portfolio in a very simple Monte Carlo model.

## Another cool thing: you can also read data from hosted sources (could be useful to read directly from a client database).
## I hosted this file on my GitHub page
InputForecasts <- read.csv("https://raw.githubusercontent.com/benvander/RinBain/master/data/CompanyScenarios.csv")
InputForecasts <- InputForecasts[,2:8]; rownames(InputForecasts) <- c("High","Mid","Low")
InputForecasts

## Model each company's outcomes as normally distributed, with the mean equal to the Mid case, and standard deviation equal to the average of the distance to the High and Low cases.

CompanyMeans <- as.numeric(InputForecasts[2,])
CompanySDs <- (InputForecasts[1,]-InputForecasts[3,])/2

## Create a correlation matrix between the companies

PerfCor <- 1
SampCor <- .7
HighCor <- .9
LowwCor <- .5

CorMat <- matrix(c(
  PerfCor,SampCor,SampCor,SampCor,SampCor,SampCor,LowwCor,
  SampCor,PerfCor,SampCor,SampCor,HighCor,SampCor,LowwCor,
  SampCor,SampCor,PerfCor,SampCor,SampCor,HighCor,LowwCor,
  SampCor,SampCor,SampCor,PerfCor,SampCor,SampCor,LowwCor,
  SampCor,HighCor,SampCor,SampCor,PerfCor,SampCor,LowwCor,
  SampCor,SampCor,HighCor,SampCor,SampCor,PerfCor,LowwCor,
  LowwCor,LowwCor,LowwCor,LowwCor,LowwCor,LowwCor,PerfCor),
  nrow=length(CompanyMeans),ncol=length(CompanyMeans),byrow=TRUE)

Sigma <- diag(CompanySDs) %*% CorMat %*% diag(CompanySDs)
Decomp <- chol(Sigma)

## Set a number of trials!

NumTrials <- 100000
Z <- matrix(rnorm(length(CompanyMeans)*NumTrials),ncol=NumTrials,nrow=length(CompanyMeans))
Y <- CompanyMeans + Decomp%*%Z
PortfolioOutcomes <- colSums(Y)

c(mean(PortfolioOutcomes),sd(PortfolioOutcomes))
hist(PortfolioOutcomes,main="Portfolio Outcomes",xlab="Portfolio Profits",col="gray70")

## We can also write it out so it can be copied right into the Wizard!

Outhist <- hist(PortfolioOutcomes,freq=TRUE)
WizardData <- rbind(Outhist$breaks,c(Outhist$density,0))
write.csv(WizardData,file="PortfolioOutcomes.csv")

##############################################################

## Another example with cluster analysis. Here's some more data.

data <- read.csv("https://raw.githubusercontent.com/benvander/RinBain/master/data/TourTimes.csv")
Times <- data[,2:3]

## Let's explore.

plot(Times)
abline(lm(Times[,2]~Times[,1]))
cor(Times)

## Correlation! But that doesn't look like the whole story... 
## There seem to be two distinct groups, just if we're looking at it. Let's try cluster analysis!

MyClusters <- kmeans(Times,2)
plot(Times, col = MyClusters$cluster,main="Aha! Two clusters!")
points(cl$centers, col = 1:2, pch = 8, cex = 2) # Shows the center of the clusters
abline(lm(Times[,2]~Times[,1]))

## That's obviously a very simple version of cluster analysis... 
## My advice for most people is to not too much cluster analysis on your own
## There's a lot of mathematical nuance you'll miss if you blindly apply the tools.

##############################################################

## And here we are! That's a nice brief intro to R and how you might make use of it at Bain. 
## I hope you enjoyed, and please let me know if you have questions!

##############################################################


## Answers

# 2) 

CustInfo[1:10,]
AgeVsSpend <- cbind(CustInfo$Gender,CustInfo$AmountSpent)
AgeVsSpend <- na.omit(AgeVsSpend)
MyClusters <- kmeans(AgeVsSpend,2)
plot(AgeVsSpend,col=MyClusters$cluster)

# 3)

summary(SurveyData$npsClient)
NPSresult <- rep(NA,nrow(SurveyData))
NPSresult <- replace(NPSresult,SurveyData$npsClient<=8,"Neutral")
NPSresult <- replace(NPSresult,SurveyData$npsClient<=6,"Detractor")
NPSresult <- replace(NPSresult,SurveyData$npsClient>=9,"Promoter")
table(NPSresult,SurveyData$LikelyReturn)
