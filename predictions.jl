using Pkg, Revise, DataFrames, CSV, LinearAlgebra, Dates, Statistics, MLJ, MLJBase, MLJModels, MLJLinearModels, Plots, Flux, MLBase, StatsBase, ExcelReaders

CSV.read("C:\\Users\\dinko\\github\\crypto-daily-movements\\Coinbase_BTCUSD_d.csv")

readxlsheet("Coinbase_BTCUSD_d.csv", "Sheet1", skipstartrow=1)
