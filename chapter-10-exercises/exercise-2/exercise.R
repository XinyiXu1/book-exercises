# Exercise 2: working with data frames

# Create a vector of 100 employees ("Employee 1", "Employee 2", ... "Employee 100")
# Hint: use the `paste()` function and vector recycling to add a number to the word
# "Employee"
employees <- paste("Employee", c(1:100))
print(employees)

# Create a vector of 100 random salaries for the year 2017
# Use the `runif()` function to pick random numbers between 40000 and 50000
salaries_in_2017 <- runif(100, min = 40000, max = 50000)
print(salaries_in_2017)

# Create a vector of 100 annual salary adjustments between -5000 and 10000.
# (A negative number represents a salary decrease due to corporate greed)
# Again use the `runif()` function to pick 100 random numbers in that range.
annual_salary <- runif(100, min = -5000, max = 10000)

# Create a data frame `salaries` by combining the 3 vectors you just made
# Remember to set `stringsAsFactors=FALSE`!
salaries <- data.frame(
  employees,salaries_in_2017,annual_salary,
  stringsAsFactors=FALSE
)

# Add a column to the `salaries` data frame that represents each person's
# salary in 2018 (e.g., with the salary adjustment added in).
salaries[,4] =  salaries_in_2017 + annual_salary
colnames(salaries)[4] <-  "salary_in_2018"

# Add a column to the `salaries` data frame that has a value of `TRUE` if the 
# person got a raise (their salary went up)
salaries[,5] =  salaries$salary_in_2018 - salaries$salaries_in_2017 > 0
colnames(salaries)[5] <-  "get_raise"
View(salaries)

### Retrieve values from your data frame to answer the following questions
### Note that you should get the value as specific as possible (e.g., a single
### cell rather than the whole row!)

# What was the 2018 salary of Employee 57
salaries[salaries$employees == "Employee 57", "salary_in_2018"]

# How many employees got a raise?
nrow(salaries[salaries$get_raise == TRUE, ])

# What was the dollar value of the highest raise?
biggest_raise <- max(salaries$annual_salary)
salaries[salaries$annual_salary == biggest_raise,"annual_salary"]

# What was the "name" of the employee who received the highest raise?
salaries[salaries$annual_salary == biggest_raise,"employees"]

# What was the largest decrease in salaries between the two years?
largest_decrease <- min(salaries$annual_salary)
salaries[salaries$annual_salary == largest_decrease,"annual_salary"]

# What was the name of the employee who recieved largest decrease in salary?
salaries[salaries$annual_salary == largest_decrease,"employees"]

# What was the average salary change?
change <- salaries[,"annual_salary"]
mean(change)

# For people who did not get a raise, how much money did they lose on average?
pay_cut <- salaries[salaries$get_raise == FALSE,"annual_salary"]
mean(pay_cut)

## Consider: do the above averages match what you expected them to be based on 
## how you generated the salaries?
Yeah
# Write a .csv file of your salary data to your working directory
write.csv(salaries, "salaries_file.csv",row.names = FALSE)
