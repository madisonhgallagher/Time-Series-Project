# Time-Series-Project
# DS4002_LAM
DS4002 Spring 2025 Project Group LAM
Madison Gallagher, Lauren Turner, Aroosha Solomon

## Repository Contents
This repository is for the Spring 2025 session of DS 4002 at The University of Virginia's School of Data Science. It contains the materials used to perform multivariate time series analysis on three years' worth of pollutant levels in Los Angeles, California. There are three main folders: DATA, SCRIPTS, and OUTPUT.

## Software and Platform
For this project, we used Google Colab and open source packages such as SKlearn. 
The additional packages installed and utilized were: matplotlib, numpy, statsmodels.tsa.stattools, statsmodels.tsa.vector_ar.var_model, pandas, and sklearn. The platform used was Windows. 
We got our data from the EPA, and downloaded each year's worth of data for one pollutant as one CSV file. This meant we had a total of 12 files. 

## Documentation Map
![image](https://github.com/user-attachments/assets/bf78873a-402a-4e0d-b8ba-fa851ac0c64c)



## Reproducing Results
### Gathering Data
To gather the data visit the Environmental Protection Agency's website and navigate to their data page. Select the desired locaiton, collections sites, and pollutant types. In our case we selected Los Angeles, all collection sites, and four pollutant types: PM10, PM2.5, CO, and Ozone. Select the year you wish to download the data for. We selected 2024, 2023, and 2022. Note that you can only download one year's worth of data in one CSV so you will have to repeat this step for each year and each pollutant. Download all necessary CSVs. In our case, 12 total CSVs: 4 pollutants and 3 years. Name them appropriately.

### EDA
Import the 12 CSV files into a python notebook. Join the 3 years worth of each pollutant into one CSV. You will have 4 dataframes with three year's of data each. You will need to find the average value of each pollutant for each recorded date because each collection site will have a unique recorded pollutant level. Use the groupby() and the mean() function to groupby date and then find the mean value of the pollutant. Export the final dataframe to a CSV for further use.
EDA will also include creating exploratory plots. Plot each pollutant level over time individually and together. This includes finding the average of each pollutant for each month. Check for correlation and see if you notice any seasonal patterns or trends over time. You can build these plots using plt.plot().
Fianlly, check for relationship between the variables using Granger's Causality Test. This will help with the mutivariate time series analysis by identifying if there are pairwise relationships between the variables. If the p-value is low (< 0.05) at any lag, the first variable Granger-causes the second.

Example Code:
from statsmodels.tsa.stattools import grangercausalitytests
max_lag = 5  # Choose a max lag based on your data characteristics
grangercausalitytests(df[['Var1', 'Var2']], max_lag, verbose=True)
grangercausalitytests(df[['Var2', 'Var3']], max_lag, verbose=True)
grangercausalitytests(df[['Var3', 'Var4']], max_lag, verbose=True)
grangercausalitytests(df[['Var4', 'Var1']], max_lag, verbose=True)


### Analysis: 

First, combine your four pollutant's CSVs into one dataframe in a pyhton notebook. The goal of this section is to build a multivariate time series model that will most accurately predict the four pollutant levels for the alst two motnhs of data. Split the data into a test set and a training set. The test set should include the last two months of data. 
Build multiple TS models and compare their accuracy and then choose the model that best predicts for your dataset. For our models we built a vector auto regression (VAR) model, a Seasonal Autoregressive Integrated Moving-Average with Exogenous Regressors (SARIMAX) model, and a Long Short Term Memory (LSTM) and compared them using mean average error (MAE), %MAE and accuracy of predictions. We selected the LSTM model due to it's high accuracy of predictions as well as it's ability to predict all four pollutants versus one at a time.
When building the model, in order to fine tune the model to your data set you may have to preprocess the data by performing differencing. 

#Building the LSTM

#Comparing the models
We used MAE, %MAE, and accuracy score to compare the performance of the different models. We also plotted the predicted vesus actual for each model and visually inspected the performance of the model. Use the model with the lowest MAE and percent MAE. Percent MAE will account for the range of the varaible. A %MAE below 20% is considered reasonable. Compare the accuracy score of each pollutant using the code below. For this project our goal was to score an accuracy of 80% or above.

EXAMPLE MAE CODE:
#Calculate MAE and MAE % for each pollutant
for col in df.columns:
    mae = mean_absolute_error(test_df[col], forecast_df[col])
    data_range = test_df[col].max() - test_df[col].min()

EXAMPLE ACCURACY SCORE CODE:
#Get the range of actual values (max - min)
range_pm25 = test_df['PM2.5'].max() - test_df['PM2.5'].min()
#Compute accuracy
accuracy = (1 - (mae / range_pm25)) * 100




