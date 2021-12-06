module OneHot

using Random
using Base: tail, front

export OneHotArray

include("array.jl")
include("encoding.jl")
include("sample.jl")
include("stats.jl")
include("util.jl")

end # module
