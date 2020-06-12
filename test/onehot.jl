using OneHot, Test, Random
using OneHot: categorical_rand

q = 10
A = rand(1:q, 4,5,6)
@inferred OneHot.encode(A, q)
X = OneHot.encode(A, q)
@test size(X) == (q, size(A)...)
for i in CartesianIndices(A), a = 1:q
    @test X[a,i] == (A[i] == a)
end
@inferred OneHot.decode(X)
@test OneHot.decode(X) == A

logits = randn(5,3,4)
P = OneHot.softmax(logits)

@inferred OneHot.sample_from_logits(logits)
R = OneHot.sample_from_logits(logits)
@test size(R) == size(P)
for k=1:4, j=1:3
    @test count(R[:,j,k]) == 1
end

@inferred OneHot.sample(P)
R = OneHot.sample(P)
@test size(R) == size(P)
for k=1:4, j=1:3
    @test count(R[:,j,k]) == 1
end

@testset "categorical_rand" begin
    Random.seed!(84)
    ps = (0.2, 0.5, 0.3)
    samples = Dict{Int,Int}()
    N = 1000000
    for _ = 1:N
        s = categorical_rand(ps)
        samples[s] = get(samples, s, 0) + 1
    end
    for (s,c) in samples
        @test c ./ N ≈ ps[s] atol=1e-2
    end
end
