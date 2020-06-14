using OneHot, Test, Random

@testset "sample" begin
    θ = randn(5,5,4)
    @test size(OneHot.sample_from_logits(θ)) == size(OneHot.sample_from_logits_gumbel(θ))
end
