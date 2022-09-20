using XCFunctionals
using Test

@testset "XCFunctionals.jl" begin
    # Write your tests here

    xc = build_functional("lda_example", 1,2; compile=true)
    @test xc[1](1.2) ≈ -0.4454241863223889

    # GGA test
    xc = build_functional("gga_example", 1,2; compile=true)
    @test xc[1](1.2, 0.1) ≈ 0.27443480972529277

end
