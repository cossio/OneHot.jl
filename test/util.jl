using OneHot, Test, Random
using OneHot: argmaxdrop, argmaxdropfirst, tuplen

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
