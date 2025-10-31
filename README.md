## Statistical Analysis of High School and College Entrance Exam Scores in Taiwan with Online Data: A Fully Reproducible Approach with R Markdown  

Christine P. Chai  
<cpchai21@gmail.com>

Preprint on ResearchGate: <https://bit.ly/4qz2Dt1>

#### Executive Summary

In this project, we investigate the relationship between high school and college entrance exam scores in Taiwan using self-reported data online. The goal is to demonstrate reproducible statistical analysis in R Markdown and LaTeX to PDF. We start by exploring the data to formulate the problem statement and identify the appropriate model, which can be an iterative process. We eventually decided on a binary outcome of the college entrance exams, and hence implemented a logistic regression model. We also validate the model with out-of-sample prediction methods, including cross validation as well as separate training and testing sets. Finally, we use some metrics to evaluate the model performance. The end-to-end data analysis can be compiled with a single button in RStudio, without copying-and-pasting output from one program to another.   

#### Disclaimer

The opinions and views expressed in this manuscript are those of the author, and do not necessarily state or reflect those of any institution or government entity. The author has a statistics and engineering background, without any training in middle school or high school teaching.

#### Data Source

We obtained the high school and college entrance score data sample from [PTT](https://term.ptt.cc/), the largest terminal-based bulletin board in Taiwan. The data
from PTT are more representative than if we had collected on our own, because almost anyone could get a PTT account and reply to the post. The majority of scores were reported in May 2015, and a few scores were reported in the following month or later.   

Data link: <https://www.ptt.cc/bbs/SENIORHIGH/M.1432729401.A.995.html>
