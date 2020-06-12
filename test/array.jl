using OneHot

X = OneHotArray(rand(1:4, 5), 4)

for i = 1:size(X,2)
    @test OneHot.decode(X[:,i]) == X.c[i]
end

A = randn(3,4)
@test A * X == A[:, X.c]
@inferred A * X
