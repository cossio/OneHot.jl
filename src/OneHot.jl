module OneHot

using Base: tail, front
using Random: GLOBAL_RNG, AbstractRNG, randexp

export OneHotArray

include("array.jl")
include("encoding.jl")
include("sample.jl")
include("stats.jl")
include("util.jl")

end # module
