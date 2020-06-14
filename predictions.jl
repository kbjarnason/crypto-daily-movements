#%%md
Crypto Daily Movements
By Kristian Bjarnason & Mr. Valentino

TODO
find covariances

IDEAS
Window size choices (100, 500, 1000)
Models
Grid search vs Random search for tuning parameters
Multiple models stacked?
maybe split to only predict last 100 days for speed?
lagged variables
NN (flux, TF)

#%%
using Pkg, Revise, LinearAlgebra, DataFrames, CSV, Impute, Dates, Statistics, StatsBase, MLJ, MLJBase, MLJModels, MLJLinearModels, Plots

#%%md
Constants
#%%
WINDOW_SIZE = 100

#%%md
Functions
#%%


#%%
BTC = CSV.read("Coinbase_BTCUSD_d.csv")
ETH = CSV.read("Coinbase_ETHUSD_d.csv")
LTC = CSV.read("Coinbase_LTCUSD_d.csv")


describe(BTC)

#%%
cryptos = [BTC, ETH, LTC]
crypto_names = ["BTC", "ETH", "LTC"]

for (x,item) in enumerate(cryptos)
    item.LR =  append!([0.0], log.(item.Close[2:end]) - log.(item.Close[1:end-1]))
    cryptos[x] = item[2:end,:]
end

cryptos[1].LR













#END
