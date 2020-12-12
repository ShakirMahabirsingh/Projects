#!/usr/bin/env python
# coding: utf-8

# # Finance Data Capstone Project 
# 
# In this project I focus on exploratory data analysis and working with the pandas framework. The goal of this project is to demonstrate my expertise with EDA and working in various ways with dataframes. Tested knowledge of the *pandas* library is a very powerful skill for a data scientist. It serves as the foundation for future complexities. 
# ____
# I focus on bank stocks and see how they progressed throughout the [financial crisis](https://en.wikipedia.org/wiki/Financial_crisis_of_2007%E2%80%9308) all the way to early 2016.

# ## Get the Data
# 
# The data is already downloaded in a large dataset for us. I will read it in and load my desired libraries so I can take a look. 
# 
# ### The Imports
# 
# I import the typical data science libraries.

# In[2]:


from pandas_datareader import data, wb
import pandas as pd
import numpy as np
import datetime
import seaborn as sns
get_ipython().run_line_magic('matplotlib', 'inline')


# ## Data
# 
# I will get stock information for the following banks:
# * Bank of America
# * CitiGroup
# * Goldman Sachs
# * JPMorgan Chase
# * Morgan Stanley
# * Wells Fargo
# 
# **A pickle file was provided with the data so I simply read that in. This was supplied by Udemy!
#   I then splice the specific data for each bank.**

# In[7]:


df = pd.read_pickle('all_banks')
BAC = df['BAC']
JPM = df['JPM']
WFC = df['WFC']
GS = df['GS']
C = df['C']
MS = df['MS']


# **Creating a list of tickers**

# In[8]:


tickers = ['BAC', 'C', 'GS', 'JPM', 'MS', 'WFC']


# **I then concatenate the various splices into one large dataframe. I do this to avoid making direct changes to the pickle file. I can also specify my keys as the *ticker* list**

# In[9]:


bank_stocks = pd.concat([BAC, C, GS, JPM, MS, WFC], axis = 1, keys = tickers)
bank_stocks


# **Setting my column names**

# In[10]:


bank_stocks.columns.names = ['Bank Ticker','Stock Info']


# **Checking the head to make sure the dataframe is built properly**

# In[11]:


bank_stocks.head()


# # EDA
# 
# Let's explore the data a bit! Throughout this project I use .xs() to quickly show me the info I want. The ability to pull a cross-section on specific data is very useful. I can specify my key and level without digging too deep.

# **What is the max Close price for each bank's stock throughout the time period?**

# In[12]:


bank_stocks.xs(key='Close',axis=1, level='Stock Info').max()


# **Creating a new empty DataFrame called returns. I define returns as the equation below:**
# 
# $$r_t = \frac{p_t - p_{t-1}}{p_{t-1}} = \frac{p_t}{p_{t-1}} - 1$$

# In[14]:


returns = pd.DataFrame()


# **I call the pct.change() method on the Close column to create the return column values. I build a for loop to go through each Bank Ticker, create a return column, then add it as a column in the *returns* dataframe.**

# In[15]:


for tick in tickers: 
    returns[tick + ' return'] = bank_stocks[tick]['Close'].pct_change()
returns.head()


# **I use seaborn to create a pairplot. This can show us a lot of data at once. From a quick look I can see that Citigroup seems to be acting strange**

# In[20]:


sns.pairplot(returns[1:])


# **Using the returns DataFrame, I try to see which date had the worst return for the banks**

# In[16]:


returns.idxmin()


# **Citigroup's worst and best date seem to be very close to eachother. I learn this from pulling this insight from the data. It turns out, Citigroup had their worst day but then split their stock a few days later**

# In[17]:


returns.idxmax()


# * See Solution for details

# **The standard deviation tells us the possible variance of the values in relation to the mean. This would mean a higher SD has more variance (higher chance of being different from the mean). This would equate to risk! I look to see which stock seems the most riskiest overall and which is most riskiest in 2015**

# In[18]:


returns.std()
#Citigroup is the riskiest with a 0.1799 std, more varability than the other stocks


# In[19]:


returns.loc['2015-01-01':'2015-12-31'].std()
#BAC or MS have riskiest stocks during 2015 


# **I create a distribution plot using seaborn of the 2015 returns for Morgan Stanley**

# In[20]:


sns.distplot(returns.loc['2015-01-01':'2015-12-31']['MS return'], color = 'green', bins = 100)


# **I create a distribution plot using seaborn of the 2008 returns for CitiGroup**

# In[21]:


sns.distplot(returns.loc['2008-01-01':'2008-12-31']['C return'], color = 'red', bins=100)


# ____
# # More Visualization
# 
# **I do more visualizations, in particular working with the cufflinks library from some interactive plots.**

# In[22]:


import matplotlib.pyplot as plt
import seaborn as sns
sns.set_style('whitegrid')
get_ipython().run_line_magic('matplotlib', 'inline')

# Optional Plotly Method Imports
import plotly
import cufflinks as cf
cf.go_offline()


# **I create a line plot showing Close price for each bank for the entire index of time. I pull this cross-section of Close using .xs()**

# In[23]:


returnClose = bank_stocks.xs(key='Close',axis=1, level='Stock Info').iplot()


# ## Moving Averages
# 
# Let's analyze the moving averages for these stocks in the year 2008. 
# 
# **Plotting the rolling 30 day average against the Close Price for Bank Of America's stock for the year 2008**

# In[24]:


plt.figure(figsize=(12,6))
BAC['Close'].loc['2008-01-01':'2009-01-01'].rolling(window=30).mean().plot(label='30 Day Avg')
BAC['Close'].loc['2008-01-01':'2009-01-01'].plot(label='BAC CLOSE')
plt.legend()


# **Creating a heatmap of the correlation between the stocks Close Price.**

# In[25]:


sns.heatmap(bank_stocks.xs(key='Close',axis=1, level='Stock Info').corr(), annot=True)


# **Using seaborn's clustermap to cluster the correlations together**

# In[26]:


sns.clustermap(bank_stocks.xs(key='Close',axis=1, level='Stock Info').corr(), annot=True)


# # Part 2 
# 
# I experiment with the cufflinks library to create some interesting graphs. It is a very powerful tool that can make great use of user interaction.

# **Creating a candle plot of Bank of America's stock from Jan 1st 2015 to Jan 1st 2016.**

# In[27]:


BAC[['Open','Close','High','Low']]['2015-01-01':'2016-01-01'].iplot(kind='candle')


# **Creating a Simple Moving Averages plot of Morgan Stanley for the year 2015.**

# In[28]:


MS[['Open','Close','High','Low']]['2015-01-01':'2015-12-31'].rolling(window=30).mean().ta_plot(study='sma')


# **Using .ta_plot(study='boll') to create a Bollinger Band Plot for Bank of America for the year 2015.**
# 
# We can see our lines don't over/under estimate any points as does a SMA. The Bollinger Band is based on SD so they adjust to volatility quite well 

# In[29]:


BAC[['Open','Close','High','Low']]['2015-01-01':'2015-12-31'].ta_plot(study='boll')

