using OneHot, Test, Random

@testset "classify" begin
    A = randn(5,5,4)
    cl = OneHot.classify(A)
    for I in CartesianIndices(cl)
        @test maximum(A[:,I]) == A[cl[I],I]
    end
end
