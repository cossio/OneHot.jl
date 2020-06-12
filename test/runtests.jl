using SafeTestsets

@safetestset "array" begin include("array.jl") end
@safetestset "util" begin include("util.jl") end
@safetestset "onehot" begin include("onehot.jl") end
@safetestset "stats" begin include("stats.jl") end
