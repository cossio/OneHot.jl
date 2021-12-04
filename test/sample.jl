using OneHot, Test, Random, Statistics

@testset "sample" begin
    θ = randn(5,5,4)
    @test size(OneHot.sample_from_logits(θ)) == size(OneHot.sample_from_logits_gumbel(θ))
end

@testset "gumbel" begin
    Random.seed!(3)
    @test mean(OneHot.randgumbel() for _ = 1:10^6) ≈ MathConstants.γ rtol=0.01
    @test std(OneHot.randgumbel() for _ = 1:10^6) ≈ π / √6 rtol=0.01
end
