#=
Let's load some packages
=#

using OneHot, CairoMakie, Random, BenchmarkTools
nothing #hide

#=
Setup the size of the examples we'll look at
=#

q = 20
N = 200
M = 400
nothing #hide

#=
Benchmark normal matrix multiply.
This doesn't exploit OneHot structure of `X`.
=#

@benchmark A * X setup=(A=randn(M,q); X=Array(OneHotArray(rand(1:q, N), q)))

#=
This package implements efficient matrix multiply by a `OneHotArray`.
=#

@benchmark A * X setup=(A=randn(M,q); X=OneHotArray(rand(1:q, N), q))

#=
That's about 20x faster!
We can also check that these two codes are computing the same thing.
=#

A = randn(M, q)
X = OneHotArray(rand(1:q, N), q)
A * X ≈ A * Array(X)
