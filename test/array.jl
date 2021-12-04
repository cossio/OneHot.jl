using OneHot
using Base: tail, front

X = OneHotArray(rand(1:4, 5), 4)

for i = 1:size(X,2)
    @test OneHot.decode(X[:,i]) == X.c[i]
end

A = randn(3,4)
@test A * X == A[:, X.c]
@inferred A * X

B = randn(3,3)
@test_throws DimensionMismatch B * X

@test X[:,1:3] isa OneHotArray{2}
@inferred X[:,1:3]

for I in eachindex(X)
    i = Tuple(I)
    @test X[I] == (first(i) == X.c[tail(i)...])
end
