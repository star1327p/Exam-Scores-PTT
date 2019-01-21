# Data Source: ptt - SENIORHIGH
# https://www.ptt.cc/bbs/SENIORHIGH/M.1432729401.A.995.html
# 197 rows of (high school entrance exam percentile, 1st college entrance exam score)

data = read.csv("ptt_SENIORHIGH_data.csv")
View(data)

# Second version: Added titles and labels to the data visualizations.
# Next step: Create an .Rmd file!

# ------------------------------------------------------------------------

# High school entrance exam scores: Remove missing values
uni_HS_score = data$HighSchool_PR[which(data$HighSchool_PR != -1)]
hist(uni_HS_score, main = "Histogram of High School Entrance Exam Scores",
     xlab="Score Percentile (PR)")
summary(uni_HS_score)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 51.00   85.00   92.00   89.82   97.00   99.00 

uni_HS_top = uni_HS_score[which(uni_HS_score >= 90)]
length(uni_HS_top) # 117
table(uni_HS_top)
# HighSchool 90 91 92 93 94 95 96 97 98 99 
# Frequency   7  6  9 11 12  7  5 18 15 27 
hist(uni_HS_top, main = "Histogram of Top High School Entrance Exam Scores",
     xlab="Score Percentile (PR) (90 and above)",xlim=c(90,100))

# ------------------------------------------------------------------------

# College entrance exam scores: Remove missing values
uni_college_score = data$CollegeEntrance_Score[which(data$CollegeEntrance_Score != -1)]
hist(uni_college_score, main = "Histogram of College Entrance Exam Scores",
     xlab="Score (max possible is 75)",xlim=c(30,80))
summary(uni_college_score)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 34.0    58.0    64.5    62.7    69.0    75.0 

uni_college_top = uni_college_score[which(uni_college_score >= 65)]
length(uni_college_top) # 97
table(uni_college_top)
# College   65 66 67 68 69 70 71 72 73 74 75 
# Frequency 11 12 10  9  7 10 10 12  9  5  2
hist(uni_college_top, main = "Histogram of Top College Entrance Exam Scores",
     xlab="Score (65 and above, up to 75)",breaks=c(64:75),xlim=c(64,76))

# Seelction bias?! Both high school and college exam scores are left-skewed.

# ------------------------------------------------------------------------

# Start the correlation between HighSchool and College entrance scores

cor(data$HighSchool_PR, data$CollegeEntrance_Score)
# 0.04039068
# But this is NOT right! We need to remove the "-1" (missing values)

missing_rows = which(data$HighSchool_PR == "-1" | data$CollegeEntrance_Score == "-1")
# Indices: 6  19  71  85  88  96 132 183 195 => nine in total

# Now this is right. :)
data_corr = data[-missing_rows,]
cor(data_corr$HighSchool_PR, data_corr$CollegeEntrance_Score)
# 0.5074473

plot(data_corr$HighSchool_PR, data_corr$CollegeEntrance_Score,
     main = "Correlation Between High School and College Entrance Sores",
     xlab="High School Entrance Score Percentile (PR)",
     ylab="College Entrance Score")

# ------------------------------------------------------------------------

# Looking forward: Given a good high school entrance exam score, what would happen?
data_topHS = data_corr[which(data_corr$HighSchool_PR >= 90),]
plot(data_topHS$HighSchool_PR, data_topHS$CollegeEntrance_Score,
     main ="Given a good high school entrance exam score (PR 90 and above)",
     xlab="High School Entrance Score Percentile (PR)",
     ylab="College Entrance Score")
cor(data_topHS$HighSchool_PR, data_topHS$CollegeEntrance_Score)
# 0.5475427

# Looking backward: Given a good college entrance exam score, what had happened?
data_topCollege = data_corr[which(data_corr$CollegeEntrance_Score >= 65),]
plot(data_topCollege$HighSchool_PR, data_topCollege$CollegeEntrance_Score,
     main ="Given a good college entrance exam score (65 and above)",
     xlab="High School Entrance Score Percentile (PR)",
     ylab="College Entrance Score")
cor(data_topCollege$HighSchool_PR, data_topCollege$CollegeEntrance_Score)
# 0.05652606 
# (Really? Because some people have low high school score, 
#                  but high college entrance score.)

# If we exclude the extreme values (typically High School PR <=80)...
data_topCollege_truncated = data_topCollege[which(data_topCollege$HighSchool_PR >= 80),]
cor(data_topCollege_truncated$HighSchool_PR, 
    data_topCollege_truncated$CollegeEntrance_Score)
# 0.3801915
# The correlation is still low,
# since there are too few data on the people with low high school PR scores.

# ------------------------------------------------------------------------

# I don't think any of the analysis is interesting, 
# but I would still like to post my code on GitHub, 
# and perhaps make an .Rmd report for reproducibility!

# Just can't believe that the data are so left-skewed.

# My high school entrance score = 95
# My college entrance score = 69
# None of them is accurate because I got admitted to much higher-ranked
# institutions, both high school and college.
# But the data pair (95, 69) seems reasonable.

# Conclusion: ptt data are a biased sample!
