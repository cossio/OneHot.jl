module OneHot

using Random
using Base: tail, front

export OneHotArray, OneHotVector, OneHotMatrix, OneHotVecOrMat

include("array.jl")
include("util.jl")
include("sum.jl")
include("tensormul.jl")

end # module
