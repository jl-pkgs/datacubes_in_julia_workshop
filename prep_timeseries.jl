# This is a helper script to prepare the time series data for the exercise.
# This assumes, that you have already downloaded the era5 subset for europe on your local machine.

using YAXArrays
using CSV
using DataFrames
using Zarr

sublocal = Cube("examples/data/era5_germany.zarr/")

places = Dict(
:jena => sublocal[Longitude=Near(11.58), Latitude=Near(50.95)],
:oslo => sublocal[Longitude=Near(10.80), Latitude=Near(59.91)],
:sahara => sublocal[Longitude=Near(11.58), Latitude=Near(30.95)],
:florence => sublocal[Longitude=Near(11.30), Latitude=Near(43.71)],
)

for (n, da) in places
    dt = DimTable(readcubedata(da), layersfrom=:Variable)
    CSV.write("examples/data/$n.csv", dt)
end
