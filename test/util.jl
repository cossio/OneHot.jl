using OneHot, Test, Random
using OneHot: argmaxdrop, argmaxdropfirst, tuplen, columns, softmax, softmax_online

@testset "argmaxdrop" begin
    @inferred argmaxdrop(randn(3,2,4); dims=2)
    @test size(argmaxdrop(randn(3,2,4); dims=2)) == (3,4)
    A = [3 4; 1 2]
    i = argmaxdrop(A; dims=2)
    @test A[i] == [4, 2]
end

@testset "argmaxdropfirst" begin
    @inferred argmaxdropfirst(randn(3,2,4))
    @test size(argmaxdropfirst(randn(3,2,4))) == (2,4)
    A = [3 4; 1 2]
    i = argmaxdropfirst(A)
    @test A[i] == [3, 4]
end

@testset "tuplen" begin
    @inferred tuplen(Val(5))
    @test tuplen(Val(5)) == (1,2,3,4,5)
end

@testset "columns" begin
    A = randn(4,5)
    @test columns(A) == collect(eachcol(A))
    @inferred columns(A)
    A = randn(5,5,3)
    @test vec(columns(A)) == collect(eachcol(reshape(A,5,15)))
    @inferred columns(A)
end

@testset "softmax" begin
    xs = randn(5,5,3)
    @test softmax(xs; dims=2) ≈ exp.(xs) ./ sum(exp.(xs); dims=2)
end

@testset "softmax online" begin
    xs = randn(5,5,3)
    @test softmax(xs; dims=1) ≈ softmax_online(xs)
end
