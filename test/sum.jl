using OneHot

@testset "sum" begin
    X = OneHotArray(rand(1:4, 5), 4)
    @test sum(X) == sum(x for x in X)
end
