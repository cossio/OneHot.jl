using SafeTestsets

@safetestset "array" begin include("array.jl") end
@safetestset "util" begin include("util.jl") end
@safetestset "sum" begin include("sum.jl") end
@safetestset "tensormul" begin include("tensormul.jl") end
