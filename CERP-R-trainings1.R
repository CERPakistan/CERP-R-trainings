############################################
### CERP R Training 1: Introduction to R ###
############################################

#################
## Terminology ##
#################

# R: programming language for statistical calculation
# Open-source
# Interpreted language > access via a command line-like interpreter

# RStudio: integrated development environment (IDE) that allows users to easily develop programs in R

# Working directory: the folder in a user's computer in which they are currently working; after setting the working directory,
# the user can load from and write files to this folder

setwd("C:/Users/user/Documents/Git/CERP-R-trainings")
getwd() # Print name of wd
dir() # Print names of files in wd

# base R: the main R installation which includes all basic R functionalities; can install additional capabilities through R packages

# Package: a collection of functions developed by the R community to carry out particular tasks; can be written and submitted to CRAN by anyone.

#install.packages("dplyr")

# Even if package is already installed on the users local library, the user still has to "check out" the package.

library(dplyr)

# CRAN (Comprehensive R Archival Network): A series of servers at institutions around the world which make the R software available

# Assignment operator `<-` : assigns a value to an object, e.g. object <- value

a <- 3
a^2
a * 4

b <- c(1, 2, 3)
b^2
b * 4

c <- c("x", "y", "z")
c

# Function: a collection of R commands complete a specific task; each function has (a) name(s) and arguments (can be data or specifications)

#function_name(argument1, argument2, ...)
mean(b)
typeof(a)

# Help: ?<function name>

?c

#########################
## Basic object types: ##
#########################

# Vector: an ordered sequence of data elements of the same basic type; can include numerical values, logical values or strings

b
length(b)

# Matrix: a vector with 2-dimensional shape information (can also specify row/column names)

X = matrix(1:6, nrow = 3, ncol = 2)
X

colnames(X) <- c('A', 'B')
X

# Array: matrix is special 2D case of an array/vector is 1D case of an array; an array can have one, two or more dimensions

# List: a generic vector containing other objects (not necessarily of the same object type)
# Can include: numeric vecotrs, character/string vectors, matrices, arrays and other lists

d <- list(b, c)
names(d) <- c('b', 'c')
d
length(d)

# List slicing: retrieve a *list slice* using a single square bracket operator, i.e. "[]"

d[1] # Prints a slice containing the first member of list d (which is simply the vector b)
d['b']

# Reference a *list member* directly with double square brackets, i.e. "[[]]"
d[[1]]
d[['b']]

d[['b']][1] # Prints a slice containing the first element of the first member of list d, 'b'

# data.frame: relational data table such that the columns determine variables and the rows contain observations;
# Each column may be a different variable type. Every cell must have some value and each column in a data.frame
# must have the same number of values, i.e. a cell entry must be equal to NA or empty string if the value is missing

e_ <- cbind(b, c)
e <- as.data.frame(e_)
e

colnames(e)
typeof(e) # data.frames stored as lists
is.data.frame(e)

# Subsetting a data.frame (row/column slicing): can subset data.frame by column name, index or both

e["c"]
e[1, 2] # matrix form: d[i, j]
e[1, "c"]
e[1,]
e[,2]

#######################
## Load data into R: ##
#######################

data('iris') # Existing base R data
head(iris)

is.data.frame(iris)
write.csv(iris, 'iris.csv') # Writes data.frame as .csv file

rm(iris) # Drop object

dat <- read.csv('iris.csv') # Load .csv file as data.frame
# df_name <- read.dta('file_name.dta') # Load Stata file

is.data.frame(dat)

#############################
## Explore dat data.frame: ##
#############################

colnames(dat)
head(dat)
dim(dat) # nrow(dat), ncol(dat)
summary(dat)

# Retrieve data.frame column using the dollar sign `$`

head(dat$X)
head(dat[ ,1])

mean(dat$Sepal.Length)
sd(dat$Sepal.Length)

# Subset data.frame continued:

dat[1:2, 2:4]
dat[1:2, c(2, 4, 6)]
dat[c(2, 4, 6), c('Sepal.Length', 'Petal.Length')]
sepal <- dat[, c('Sepal.Length', 'Sepal.Width')]

head(sepal[sepal$Sepal.Length > 5, ]) # Subset on row condition via logical test
head(subset(sepal, Sepal.Length > 5))

head(sepal[with(sepal, Sepal.Length > 5 & Sepal.Width < 3), ]) # ... on multiple conditions
head(subset(sepal, Sepal.Length > 5 & Sepal.Width < 3))

# Column aggregation by group:

aggregate(dat$Sepal.Length, by = list(dat$Species), FUN = mean, na.rm = TRUE)
aggregate(dat$Sepal.Length, by = list(dat$Species), FUN = sd, na.rm = TRUE)

# Create new data.frame column:

dat$Sepal.Length_large <- 0 # Append indicator variable to dat data.frame
dat$Sepal.Length_large[which(dat$Sepal.Length > 5)] <- 1

#########################
## Basic charts/plots: ##
#########################

# Histogram:

hist(dat$Sepal.Length)
hist(dat$Sepal.Length, breaks = 20)

# Scatterplot:

plot(dat$Sepal.Length, dat$Petal.Length)

# Boxplot:

boxplot(Sepal.Length ~ Species, data = dat)

####################################
## Forward-pipe operator (intro): ##
####################################

library(magrittr)
# Pipe an object forward into a function or call expression, using the form: lhs %>% rhs

iris %>% head
iris %>% head(10) # Place 'lhs' as the first argument in 'rhs' call

##################################################
## Generalized linear regression model (intro): ##
##################################################

#m <- lm(y ~ x1 + x2, data = dat)

m <- lm(Sepal.Length ~ Sepal.Width + Petal.Length, data = dat)
summary(m)