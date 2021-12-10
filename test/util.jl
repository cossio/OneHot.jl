using OneHot, Test, Random
using OneHot: argmax_

@testset "argmax_" begin
    @inferred argmax_(randn(3,2,4); dims=2)
    @test size(argmax_(randn(3,2,4); dims=2)) == (3,4)
    A = [3 4; 1 2]
    i = argmax_(A; dims=2)
    @test A[i] == [4, 2]
end

@testset "decode" begin
    A = randn(5,5,4)
    cl = OneHot.decode(A)
    for I in CartesianIndices(cl)
        @test maximum(A[:,I]) == A[cl[I],I]
    end
    @test size(cl) == size(A)[2:end]

    X = OneHotArray(rand(1:4,5,5), 4)
    cl = OneHot.decode(X)
    for I in CartesianIndices(cl)
        @test maximum(X[:,I]) == X[cl[I],I]
    end
end

q = 10
A = rand(1:q, 4,5,6)
X = @inferred OneHot.encode(A, 1:q)
@test size(X) == (q, size(A)...)
@test vec(X) == [X[i] for i=1:length(X)]
for i in CartesianIndices(A), a = 1:q
    @test X[a,i] == (A[i] == a)
end
@inferred OneHot.decode(X)
@test OneHot.decode(X) == A
@test OneHot.decode(Array(X)) == A
@inferred OneHot.decode(Array(X))
