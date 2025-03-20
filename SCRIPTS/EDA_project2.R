library(dplyr)
library(readr)
library(ggplot2)
library(ggprism)

# Load the data, skipping the extra row numbers
file_path <- "pm10_data.csv"  # Update with the actual file path
df <- read_csv(file_path, skip = 1, col_types = cols())

# Ensure column names are correctly assigned
colnames(df) <- c("Date", "Source", "Site_ID", "POC", "Daily_Mean_PM10", "Units", "Daily_AQI_Value", "Local_Site_Name", 
                  "Daily_Obs_Count", "Percent_Complete", "AQS_Parameter_Code", "AQS_Parameter_Description", 
                  "Method_Code", "CBSA_Code", "CBSA_Name", "State_FIPS_Code", "State", "County_FIPS_Code", "County", 
                  "Site_Latitude", "Site_Longitude")

# Convert Date column to Date format
df$Date <- as.Date(df$Date, format="%m/%d/%Y")

# Extract year and month
df$Year <- format(df$Date, "%Y")
df$Month <- format(df$Date, "%m")

# Ensure Daily_Mean_PM10 column is numeric
df$Daily_Mean_PM10 <- as.numeric(df$Daily_Mean_PM10)

# Calculate the average PM10 concentration for each month
df_grouped <- df %>%
  group_by(Year, Month) %>%
  summarise(Average_PM10 = mean(Daily_Mean_PM10, na.rm = TRUE))

# Create a scatter plot using ggprism
df_grouped$Date <- as.Date(paste(df_grouped$Year, df_grouped$Month, "01", sep = "-"))

plot <- ggplot(df_grouped, aes(x = Date, y = Average_PM10)) +
  geom_point(color = "blue", size = 3) +
  geom_line(color = "red", linetype = "dashed") +
  labs(title = "Monthly Average PM10 Concentration", x = "Date", y = "PM10 Concentration (µg/m³)") +
  theme_prism()

# Display the plot
print(plot)

# Save to CSV
write_csv(df_grouped, "monthly_avg_pm10.csv")


####PM2.5

library(dplyr)
library(readr)
library(ggplot2)
library(ggprism)

# Load the data, skipping the extra row numbers
file_path <- "pm10_data.csv"  # Update with the actual file path
df <- read_csv(file_path, skip = 1, col_types = cols())

# Ensure column names are correctly assigned
colnames(df) <- c("Date", "Source", "Site_ID", "POC", "Daily_Mean_PM2.5_Concentration", "Units", "Daily_AQI_Value", 
                  "Local_Site_Name", "Daily_Obs_Count", "Percent_Complete", "AQS_Parameter_Code", "AQS_Parameter_Description", 
                  "Method_Code", "CBSA_Code", "CBSA_Name", "State_FIPS_Code", "State", "County_FIPS_Code", "County", 
                  "Site_Latitude", "Site_Longitude")

# Convert Date column to Date format
df$Date <- as.Date(df$Date, format="%m/%d/%Y")

# Extract year and month
df$Year <- format(df$Date, "%Y")
df$Month <- format(df$Date, "%m")

# Ensure Daily_Mean_PM2.5_Concentration column is numeric
df$Daily_Mean_PM2.5_Concentration <- as.numeric(df$Daily_Mean_PM2.5_Concentration)

# Calculate the average PM2.5 concentration for each month
df_grouped <- df %>%
  group_by(Year, Month) %>%
  summarise(Average_PM2.5 = mean(Daily_Mean_PM2.5_Concentration, na.rm = TRUE))

# Create a new Date column for plotting
df_grouped$Date <- as.Date(paste(df_grouped$Year, df_grouped$Month, "01", sep = "-"))

# Create a scatter plot
plot <- ggplot(df_grouped, aes(x = Date, y = Average_PM2.5)) +
  geom_point(color = "blue", size = 3) +
  geom_line(color = "red", linetype = "dashed") +
  labs(title = "Monthly Average PM2.5 Concentration", x = "Date", y = "PM2.5 Concentration (µg/m³)") +
  theme_prism()

# Display the plot
print(plot)

# Save to CSV
write_csv(df_grouped, "monthly_avg_pm2.5.csv")
