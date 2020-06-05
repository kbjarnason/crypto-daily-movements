using Pkg, Revise, DataFrames, CSV, LinearAlgebra, Dates, Statistics, MLJ, MLJBase, MLJModels, MLJLinearModels, Plots, Flux, MLBase, StatsBase, XLSX, ExcelReaders

#%%md TODO

Get covariates
Setup Tensorflow
#%% Importing CSV files

cd("C:/Users/dinko/github/crypto-daily-movements")
BTC = CSV.read("Coinbase_BTCUSD_d.csv")
ETH =  CSV.read("Coinbase_ETHUSD_d.csv")
LTC = CSV.read("Coinbase_LTCUSD_d.csv")

#%% Calculating log return and append to crypto datasets
"""Log_BTC = log.(BTC.Close)
Log_ETH = log.(ETH.Close)
Log_LTC = log.(LTC.Close) """

BTC.LR = append!([0.0], log.(BTC.Close[2:end]) - log.(BTC.Close[1:end-1]))
LTC.LR = append!([0.0], log.(LTC.Close[2:end]) - log.(LTC.Close[1:end-1]))
ETH.LR = append!([0.0], log.(ETH.Close[2:end]) - log.(ETH.Close[1:end-1]))

#%% Get covariates
