# Data Source: ptt - SENIORHIGH
# https://www.ptt.cc/bbs/SENIORHIGH/M.1432729401.A.995.html
# 197 rows of (high school entrance exam percentile, 1st college entrance exam score)

data = read.csv("ptt_SENIORHIGH_data.csv")
View(data)

# First version: Draft

# ------------------------------------------------------------------------

uni_HS_score = data$HighSchool_PR[which(data$HighSchool_PR != -1)]
hist(uni_HS_score)
summary(uni_HS_score)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 51.00   85.00   92.00   89.82   97.00   99.00 

uni_HS_top = uni_HS_score[which(uni_HS_score >= 90)]
length(uni_HS_top) # 117
table(uni_HS_top)
# HighSchool 90 91 92 93 94 95 96 97 98 99 
# Frequency   7  6  9 11 12  7  5 18 15 27 

# ------------------------------------------------------------------------

uni_college_score = data$CollegeEntrance_Score[which(data$CollegeEntrance_Score != -1)]
hist(uni_college_score)
summary(uni_college_score)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 34.0    58.0    64.5    62.7    69.0    75.0 

uni_college_top = uni_college_score[which(uni_college_score >= 65)]
length(uni_college_top) # 97
table(uni_college_top)
# College   65 66 67 68 69 70 71 72 73 74 75 
# Frequency 11 12 10  9  7 10 10 12  9  5  2

# Seelction bias?! Both high school and college exam scores are right-skewed.

# ------------------------------------------------------------------------

# Start the correlation between HighSchool and College entrance scores

cor(data$HighSchool_PR, data$CollegeEntrance_Score)
# 0.04039068
# But this is NOT right! We need to remove the "-1" (missing values)

missing_rows = which(data$HighSchool_PR == "-1" | data$CollegeEntrance_Score == "-1")
# Indices: 6  19  71  85  88  96 132 183 195 => nine in total

data_corr = data[-missing_rows,]
cor(data_corr$HighSchool_PR, data_corr$CollegeEntrance_Score)
# 0.5074473

plot(data_corr$HighSchool_PR, data_corr$CollegeEntrance_Score)

# ------------------------------------------------------------------------

data_topHS = data_corr[which(data_corr$HighSchool_PR >= 90),]
plot(data_topHS$HighSchool_PR, data_topHS$CollegeEntrance_Score)
cor(data_topHS$HighSchool_PR, data_topHS$CollegeEntrance_Score)
# 0.5475427

data_topCollege = data_corr[which(data_corr$CollegeEntrance_Score >= 65),]
plot(data_topCollege$HighSchool_PR, data_topCollege$CollegeEntrance_Score)
cor(data_topCollege$HighSchool_PR, data_topCollege$CollegeEntrance_Score)
# 0.05652606 
# (Really? Because some people have low high school score, but high college entrance score.)

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
