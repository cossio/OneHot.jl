using OneHot: OneHotArray, decode
using Test: @test, @testset, @inferred, @test_throws
using Base: tail, front

X = OneHotArray(rand(1:4, 5), 4)

for i = 1:size(X,2)
    @test decode(X[:,i]) == X.c[i]
end

A = randn(3,4)
@test A[:, X.c] == @inferred A * X
@test A * X == A * Array(X)

B = randn(3,3)
@test_throws DimensionMismatch B * X

@test X[:,1:3] isa OneHotArray{2}
@inferred X[:,1:3]

for I in eachindex(X)
    i = Tuple(I)
    @test X[I] == (first(i) == X.c[tail(i)...])
end

@testset "convert to/from BitArray" begin
    X = OneHotArray(rand(1:4, 10, 5), 4)
    @test Array(X) == BitArray(X) == X
    @test OneHotArray(BitArray(X)) == X
    @test OneHotArray(X) == X
end
