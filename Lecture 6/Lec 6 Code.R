## One sample t-test
## Get sample data
set.seed(30)
x <- as.data.frame(rnorm(100, mean = 6.4, sd = 1))

## Run one sample t-test against mean 7
t.test(x, mu = 7)

## One sample t-test, alternative as greater than
t.test(x, mu = 6.8, alternative = 'greater')

## Visualize distributions
library(ggplot2)
colnames(x) <- "data"

ggplot(x, aes(x=data)) + geom_histogram(aes(y = after_stat(density)), color = 'black', fill = 'lightblue') + 
  stat_function(fun = dnorm, args = list(mean = mean(x$data), sd = sd(x$data)), lwd = 1.5, color = 'red') + 
  geom_vline(xintercept = 6.8, linetype = "dashed", color = "forestgreen") + 
  geom_vline(xintercept = 7, linetype = "dashed", color = "forestgreen")

## Two-sample t-test
# Generate data
set.seed(30)
y <- as.data.frame(rnorm(100, mean = 6.8, sd = 0.5))

# Test for differences
t.test(x,y)

## Two sample t-test, one-tailed
t.test(x,y, alternative = 'less')

## Visualize distributions
colnames(y) <- "data"
Schools <- rbind(x,y)
Schools$data1 <- ifelse(seq.int(nrow(Schools)) < 101, "Us", "Rival")
Schools$dataX <- ifelse(Schools$data1 == "Us", Schools$data, NA)
Schools$dataY <- ifelse(Schools$data1 == "Rival", Schools$data, NA)

ggplot(data = Schools, aes(x = data, group = data1, fill = data1)) + geom_density(alpha = 0.3)

## Coin initialization
coin <- c("heads", "tails")
n <- 100

## Team 1, fair coin
Prob1 <- c(0.5,0.5)
set.seed(30)
samps1 <- as.data.frame(table(sample(coin, n, replace = TRUE, prob = Prob1)))

## Team 2, weighted coin
Prob2 <- c(0.6,0.4)
set.seed(30)
samps2 <- as.data.frame(table(sample(coin, n, replace = TRUE, prob = Prob2)))

## See data
samps1
samps2

## Compare
summary <- cbind(samps1, samps2)
summary <- summary[-c(3)]
summary

# Significant win?
prop.test(x = c(39,68), n = c(100,100), alternative = "less", conf.level = 0.95)

# Cheated? One Sample proportion
prop.test(x = 68, n = 100, p = 0.5, alternative = "greater")

## Chi-sq test for association
data <- iris

data$size <- ifelse(data$Sepal.Length < median(data$Sepal.Length),
                    "small", "big"
)

# Generate contingency table
Table <- table(data$Species, data$size)
Table

# Visual Aid
ggplot(data) + aes(x = Species, fill = size) +
  geom_bar()

# Run chi-sq test
test <- chisq.test(Table)
test
test$expected

# Test against expected probability of big per species
big <- c(1, 29, 47)
test <- chisq.test(big, p = c(1/6, 1/3, 1/2))
test
test$expected
