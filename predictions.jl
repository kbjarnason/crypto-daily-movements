using Pkg, Revise, DataFrames, CSV, LinearAlgebra, Dates, Statistics, MLJ, MLJBase, MLJModels, MLJLinearModels, Plots, Flux, MLBase, StatsBase, XLSX, ExcelReaders

#%% Importing CSV files

cd("C:/Users/dinko/github/crypto-daily-movements")
BTC = CSV.read("Coinbase_BTCUSD_d.csv")
ETH =  CSV.read("Coinbase_ETHUSD_d.csv")
LTC = CSV.read("Coinbase_LTCUSD_d.csv")

#%% Calculating log return and append to crypto datasets

BTC.LR = append!([0.0], log.(BTC.Close[2:end]) - log.(BTC.Close[1:end-1]))
LTC.LR = append!([0.0], log.(LTC.Close[2:end]) - log.(LTC.Close[1:end-1]))
ETH.LR = append!([0.0], log.(ETH.Close[2:end]) - log.(ETH.Close[1:end-1]))

names(BTC)
#%%  Get covariates
#  BTC.LR_Cov = cov(BTC[["Open"]],BTC[["Close"]])"""

#%% Sck_Learn
rename!(BTC, Dict(:Close => "BTC_Close", :LR => "BTC_LR", Symbol("Volume USD") => "BTC_Volume USD"))
rename!(LTC, Dict(:Close => "LTC_Close", :LR => "LTC_LR", Symbol("Volume USD") => "LTC_Volume USD"))
rename!(ETH, Dict(:Close => "ETH_Close", :LR => "ETH_LR", Symbol("Volume USD") => "ETH_Volume USD"))


select!(BTC, Not([:Open, :Symbol, :High, :Low]))
select!(LTC, Not([:Open, :Symbol, :High, :Low]))
select!(ETH, Not([:Open, :Symbol, :High, :Low]))

Crypto = innerjoin(BTC, LTC, ETH, on=:Date)
sort!(Crypto, :Date)

NUM_DATA_POINTS = size(Crypto)[1]
WINDOW_SIZE = 500


specify model
model_lasso = @pipeline std_lasso(std_model = Standardizer(),
                                lasso = LassoLarsICRegressor(criterion = "bic"))
model = MLJ
preds = Array{}()
 for i in 1 to numdatapoints minus WINDOW size:
     dailypreds =
     for i in NUMCRYPTOS:
         Xtrain, Xtest = Crypto[], Crypto[]
         ytrain = Crypto[]

         model train xtrain ytrain

         model fit xtest

         pred = predict(model, Xtest)

         append(dailypreds, pred)
     end
 end





#%% Tensorflow implementation
# # using TensorFlow
#
# LSTMmodel = Chain(LSTM())
#
# # Add variables
# x = BTC(Close)
# w = LTC[Close]
# y_prob = exp.(x*w)
# y_prob ./= sum(y_prob,dims=2)
#
# # Build model
# sess = Session(Graph)
#
# X = placeholder(Float64, shape=[1992, 1449])
