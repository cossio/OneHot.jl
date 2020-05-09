using OneHot, Test

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
@test R isa BitArray
for k=1:4, j=1:3
    @test count(R[:,j,k]) == 1
end

@inferred OneHot.sample(P)
R = OneHot.sample(P)
@test size(R) == size(P)
@test R isa BitArray
for k=1:4, j=1:3
    @test count(R[:,j,k]) == 1
end
