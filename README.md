# SDA 2021: Predicting the Bitcoin Electricity Consumption

This code is for our research project in the course "Smart Data Analytics" (SDA) 2021. Using different models (ARIMA, GARCH, VAR, LSTM), we forecast the electrcity consumption used for Bitcoin mining. The reasoning behind this research question is that the computative power required for mining is steadily increasing. But with an exploding price (end 2021), it becomes lucrative for miners. As the bitcoin energy consumption is comparable to the energy consumption of Switzerland, this is an urgent topic. You can find the recording of our presentation [here](REPLACE).

![image info](./images/energy_transparent.png)

## Team members:
* Aleksandra Bakhareva (21-604-475) 
* Mario Blauensteiner (20-602-744) 
* Paul Kilian Kreutzer (20-600-599) 
* Tim Ludwig Leonard Matheis (21-603-907) 

## Setup

After cloning the project, `cd` to the directory where `requirements.txt` is located. If you want, you can now activate a virtual environment. Then you run `pip install -r requirements.txt` in the terminal of you choice to install all required packages. Alternatively, just look at the packages needed (listed in the requirements file) and install them manually.

## Navigation

`01_datapreprocessing`:
- scrape fincial data of bitcoin and ethereum (URL: https://coinmarketcap.com/) - requirements: google chrome(one of newest versions) + google chromedriver
- laod energy consumption data of bitcoin and ethereum (URL:......)
- prepocess and merge data

`02_statistics`:
- - analyze datasets (i.e.: correlation matrix, counts, quantile values, mean, medians, graphes,...)

