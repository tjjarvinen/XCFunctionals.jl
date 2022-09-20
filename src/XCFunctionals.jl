module XCFunctionals

using Reexport
# Write your package code here.
using ArgCheck
using Symbolics
import Symbolics.get_variables
@reexport using Symbolics:substitute
@reexport import Symbolics: CTarget, JuliaTarget

export build_functional
export generate_functional
export generate_functional_derivatives
export generate_functional_derivatives!
export list_functionals

export Functional

# Global functional variables
@variables ρ::Real σ::Real

include("definitions.jl")
include("functional_list.jl")
include("generation_tools.jl")

#include("definitions/lda_example.jl")

end
