import Aqua
import OneHot
using Test: @testset

@testset verbose = true "aqua" begin
    Aqua.test_all(OneHot; ambiguities = false)
end
