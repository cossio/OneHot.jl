using OneHot, Test, Random

@testset "classify" begin
    A = randn(5,5,4)
    cl = OneHot.classify(A)
    for I in CartesianIndices(cl)
        @test maximum(A[:,I]) == A[cl[I],I]
    end
end

@testset "entropy" begin
    A = rand(5,5,4) .+ 1 # make sure is non-zero
    s = OneHot.entropy(A)
    p = [sum(A[a,:,:]) for a = 1:5] / sum(A)
    @test sum(p) ≈ 1
    @test all(p .> 0)
    @test s ≈ -sum(p .* log.(p))
    @inferred OneHot.entropy(A)
end
