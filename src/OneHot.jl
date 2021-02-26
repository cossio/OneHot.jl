module OneHot

using Base: tail, front
import Random: GLOBAL_RNG, AbstractRNG

export OneHotArray

include("array.jl")
include("encoding.jl")
include("sample.jl")
include("stats.jl")
include("util.jl")

end # module
