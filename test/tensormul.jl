using OneHot: OneHotArray, tensormul
using Test: @testset, @test
using Tullio: @tullio

@testset "tensormul" begin
    A = OneHotArray(rand(1:3,5,3,2,4),3)
    B = randn(3,5,3,6)
    @tullio C[a,b,c] := A[i,j,k,a,b] * B[i,j,k,c]
    @test tensormul(A, B, 3) ≈ C

    @tullio C[a,b,c] := B[i,j,k,a] * A[i,j,k,b,c]
    @test tensormul(B, A, 3) ≈ C

    B = OneHotArray(rand(1:3,5,3,6),3)
    @tullio C[a,b,c] := float(A)[i,j,k,a,b] * B[i,j,k,c]
    @test tensormul(A, B, 3) ≈ C
end
