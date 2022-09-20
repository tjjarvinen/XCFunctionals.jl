
# Define parameters for the functional
# density ρ and density gradient σ are defined by default
parameters = @variables a b

# Functional definition
xc = begin
    h(ρ,a,b) = exp(-a*(ρ-b)^2)

    (ρ - b) * h(ρ,a,b)
end 


xc_info = Dict(
    "type" => :lda,      # instructions to which type function is generated
    "description" => "some_comment",

    # Default parameter values 
    "parameters" => Dict(
        a=>1,
        b=>0
    )
)