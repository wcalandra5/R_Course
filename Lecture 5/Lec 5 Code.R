## Typical function definition
# functionName(parameter)

# or...

# functionName(parameter1, parameter2, etc)


## User-defined function definition
# functionName <- function(parameter1, parameter2, ...) {
#   functionBody
#   returnValue
# }

## Simple math function
mathFunction <- function(a, b, c) {
  
  result <- a * b + c
  print(result)
  
}

## mathFunction calls
mathFunction(2, 3, 6)
#mathFunction(2, 3)
mathFunction(2, 3, 0)
mathFunction(2, 0, 4)
mathFunction(a = 10, b = 5, c = 3)
#mathFunction(a = 4, c = 7)
mathFunction(a = 2, c = 1, b = 6)

## With default parameters
mathFunctionNew <- function(a = 1, b = 4, c = 5) {
  result <- a * b + c
  return(result)
}

mathFunctionNew(2, 3, 6)
mathFunctionNew(2, 3)
mathFunctionNew(2)
mathFunctionNew(,3,)
mathFunctionNew()
mathFunctionNew(a = 10, b = 5, c = 3)
mathFunctionNew(a = 4, c = 7)
mathFunctionNew(a = 2, c = 1, b = 6)

## Generate dataframe
set.seed(101)
df <- data.frame(replicate(6, sample(c(1:10, -2), 6, rep = TRUE)))

# Rename headers, show dataframe
names(df) <- letters[1:6]
df

## Replace -2 with NA
fix_missing <- function(x) {
  x[x == -2] <- NA
  return(x)
}

# Call fix_missing()
df <- fix_missing(df)
df

## Summary stats function
summaryFunc <- function(x) {
  c(mean(x, na.rm = TRUE), 
    median(x, na.rm = TRUE),
    sd(x, na.rm = TRUE),
    mad(x, na.rm = TRUE),
    IQR(x, na.rm = TRUE))
}

# Apply the function to our dataframe
lapply(df, summaryFunc)

## Fantasy function
LmFunc <- function(data, projectedVar, dataFrameVar, predictVar, explanatory1, explanatory2) {
  
  projectedVar <- lm(data = data, predictVar ~ explanatory1+explanatory2)
  
  data$dataFrameVar <- predict(projectedVar)
  
  # Return multiple results in a list
  results <- list(
    ggplot(data, aes(x=dataFrameVar,y=predictVar))+geom_point()+geom_smooth(method=lm,se=FALSE),
    summary(projectedVar),
    vif(projectedVar)
  )
  
  return(results)
  
}

## Use from last time
#run <- LmFunc(Yearly_Data, ProjRecYds, ProjRecYdsWk, Yearly_Data$RecYdsWk, Yearly_Data$TgtWk, Yearly_Data$RecTDsWk)
#run

## Function for squares
sqFunction <- function(x) {
  print(x^2)
}
sqFunction(1)
sqFunction(2)
sqFunction(3)
sqFunction(4)

## For loop fix
sqFunction <- function(x) {
  
  for(i in 1:x) {
    print(i^2)
  }
  
}
sqFunction(4)

## While loop example
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
}
