# Counter Example
X <- 5
X <- X + 1

# Die roll
S <- 1:6

# Use function (argument1 = x, argument2 = y, ...)
S <- seq(from = 1, to = 6, by = 1)
P <- c(1/6,1/6,1/6,1/6,1/6,1/6)

# Randomization set.seed() function
set.seed(27)

# Sample function (uses randomization above, run line 13 BEFORE 16 every time)
Samps <- sample(S, 23, replace = TRUE, prob = P)
print(Samps)
summary(Samps)

# Visualizations!
hist(Samps)
boxplot(Samps)

# Change data type and save
Samps <- as.data.frame(Samps)

summary(Samps)
