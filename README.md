# Projects 
Every Data Scientist needs a hub to showcase their growth, progress and projects. This repository containins my various DS Projects I've worked on.
As I upload more projects, I will give a brief summary of each project below.





## Covid-19 & Global Social Measures Team Project

This project spanned a couple weeks. I took the mantle of lead coder/developer for the project 
because I knew it would force me into a position requiring me to learn. By putting the weight (grade) of the entire project and my team's trust on myself, I knew I'd have to excel.
We found various global datasets on Kaggle and after settling on one major one, I took it from there. I cleaned, loaded, and explored my data to find any preliminary analysis. 
Since we decided on 4 countries to analyze, it would require 4 seperate models. 
After testing a couple linear regression models for performance, then choosing the best ones for each country, I visualized our findings. We matched these findings with 
real life Covid social measures and was able to suggest accurate and interesting inferences. This analysis is covered in the Research Paper. 



##  ETL Database Exercises 

This project was a string of exercises testing my ability to code proper ETL pipelines in order to create a database that could be visualized in Tableau. I was given various
csv files and was tasked with loading each into Pentaho and establishing a Fact Table at the end. The only dimension requiring additional work was the Date Dimension which needed
to be created from scratch. I simply simulated numerous dates for a specific span of time, masked and passed the values along, then loaded it into my final table.
Finally, after loading my tables into Tableau, I came up with two KPIs for the data and visualized accordingly. This is documented in the pdf. 



##  Titanic Random Forest Survivability

This is the first data science project/competition on Kaggle. I was given a training and testing data set and was tasked with building a Random Forest Model to accurately predict whether a sample of passengers either died or not. My model took certain variables, an n of 500 and accounted for an approximate 72% prediction success rate. I can improve this model by building a tree model, pruning and finding the optimal optimizations but this required different data than what was given. This was a fun first competition and refreshed my mind on how to work with decision models!


## Finance Data Capstone Project

This was a capstone project for the Python for Data Science course on Udemy. This allowed me to utilize all of my exploratory data analysis skills with financial data. From this project we can see some notable things in regards to these very large banks during the time period of 2006 - 2016. We can explore their returns, their opening vs closing prices, and how each of these things changed over the time frame. The amount of insight to be pulled is up to the viewer but using these EDA, statistical analysis and visualization skills, I can demonstrate outcomes that would've normally been hidden. Robust visualization skills are the mark of a good data scientist!


## Knicks 2020-2021 Season Neural Network

In my efforts to gleam some sort of excitement and hope in being a Knicks fan, I decided to take the previous season's data and construct a Neural Network. The NN would take the previous season's data as the input, run through 2 hidden layers, then finally surmise the output of the game stats. I wanted to visualize the data first so I did a lot of EDA to demonstrate the Knick's ability. I also implemented a stop-loss feature to halt the process once my epochs showed a value loss too great. The NN seems to work pretty fine, doing slighlty better than a normal Log Regression. I could imagine the NN needing a lot more training data than a short season because it's trying to predict a whole list of stats instead of a traditional singular ouput. All in all the NN predicted the Knicks doing a bit better than their last season. This doesn't include the roster update of Obi and the up and coming duo of RJ and Randle. Hopefully, my beloved Knicks blow my NN out the water and outperform better than any analytics can suggest. 


## Database Management Systems Development Project

Using 311 NYC Department data, we were tasked with developing an entire DBMS from scratch so the data could be queryed, analyzed, and stored for future scaling. The inital base file was a very large Excel sheet with 23,166 records across 20 columns. There was no way this data could be easily read or utilized in any meaningful way if left as is. I partnered with a group of 4 to engineer this whole project and after establishing various KPIs we'd like to visualize and analyze, we began work on moving the data. First, we initialized a Cloud Database with OracleDB, as this would be our target DB during ETL. Then we started defining the DW Schema with LucidChart. This required an understanding of the Kimball Methodology, normalization and data relationships to reduce the amount of redundancies and possible data error. We then moved on to defining the necessary dimensions for each subset of data and starting the ETL process through Pentaho. This was the longest part of the project as it required a fine hand to make sure every mask, load, and path is correct. Next, we established the Primary Keys and Foreign Keys so the data would relate properly. Finally, we queried our data in SQL Server to make sure everything is accessible and was built efficiently. Lastly, we loaded our data into Tableau and visualized our KPIs. This last step was the reward for our diligent work, making all that data usable for any measuring or metrics. 
