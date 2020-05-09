using SafeTestsets

@safetestset "util" begin include("util.jl") end
@safetestset "onehot" begin include("onehot.jl") end
