# Load R dataset
data <- mtcars

### Logical - either evaluates to true or false, is foundational for building computer logic
## T or F
# Use $ to access vectors
data$mpg == T
data$mpg > 15

## Operators - a bunch of different operators we use for comparison!
data$is0 <- data$vs == 0
data$is_not_0 <- data$vs != 0
data$mpg_15_17 <- data$mpg > 15 & data$mpg < 17 
data$cyl_6_or_8 <- data$cyl == 6 | data$cyl == 8
data$xorTest <- xor(data$mpg_15_17 == T, data$cyl_6_or_8 == T) # function for xor (exactly one of these cases is true)

## Mathematical Operators
# A bunch of different symbols which represent math operations!
data$cyl
data$cyl * 2
data$cyl + 2
data$cyl - 2
data$cyl / 2

data$cyl ^ 2
data$cyl ** 2

# Integer division - floors extra decimals
data$cyl %/% 2

# Modulus - remainder after division - handy to break up integers into pieces in calculations + build logic
data$cyl %% 3

## Relational Operators (greater than, less than, equal to cases, etc)
data$mpg > 17.3
data$mpg >= 17.3

### Character
# Load R dataset
data2 <- iris
# Click on "data2" and hover over the column headers - R gives you the data type (or class)!

# This is a "factor" data type - useful for grouping qualitative variables in analyses
print(data2$Species)

# How to overwrite the Species column to change it from a factor data type to a character data type
data2$Species <- as.character(data2$Species)

# Notice the "" marks - character coercion worked!
print(data2$Species)

# gsub() in action - overwrite virginica to rose
data2$Species_Change <- gsub(pattern = "virginica", 
                             replacement = "rose",
                             x = data2$Species)
data2$Species_Change

### Special Cases
data$hp <- NULL # removes column
data$qsec <- NA # makes the column empty
5 / 0 # infinity
0 / 0 # not a number

### Vectors
class(data) # class() function checks the data type/class --- dataframes are foundational to R - they are like excel sheets! Rows and columns of data
length(data) # 15 columns in this dataframe
class(data2) # also a dataframe

x <- c("Hey", "What's", "Up") # spawn a vector of three entries
class(x) # check it's type

# Use seq, rep functions to generate a vector of 150 entries (the y vector repeated 50 times)
y <- seq(from = 1, to = 5)
z <- rep(y, 30)

z[30] # find the 30th entry in the z vector
z_slice <- z[20:40] # subset and create a new z_slice vector (comes from the 20th through 40th (inclusive) entries of z)
z_slice <- as.data.frame(z_slice) # coerces the vector into a dataframe so we can see it!
z_slice

t <- rep(x, 40) # same process of rep, just on x vector, which is character data

# Difference?
x <- 1
y <- c("1")
class(x)
class(y)
# The data types are different!

# Messy
x <- c(2, T)
x <- c(2, "hello")
t <- c("hello", 3.5)
# These are really bad to work with, different data types in the same vector
# Use filters to get one data type per column, and then coerce to the proper class

# Fix
x <- c(2, "2")
x <- as.numeric(x) # R is smart here - can read that "2" as a number, even though it isn't
t <- as.numeric(t) # Not so much here - can't convert characters to numbers
is.na(t) # useful function to find NAs in vectors

# Vector Functions
mean(z)
sum(z)
var(z)
# Easy!