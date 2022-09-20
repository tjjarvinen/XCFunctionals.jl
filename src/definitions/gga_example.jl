
# Define parameters for the functional
# density ρ and density gradient σ are defined by default
parameters = @variables a::Real

# Functional definition
xc = begin
    h(σ, a) = exp(-a * σ)
    g = sub_functional("lda_example")

    exp(-g) * h(σ, a) 
end 


xc_info = Dict(
    "type" => :gga,      # instructions to which type function is generated
    "description" => "some_comment",

    # Default parameter values 
    "parameters" => Dict(
        a=>2
    )
)