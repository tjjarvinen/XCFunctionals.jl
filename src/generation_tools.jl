
function generate_functional(name; fill_params=false)
    definition = read( joinpath(@__DIR__, "definitions", name*".jl"), String )
    Meta.parseall(definition) |> eval
    tmp = Functional(xc, xc_info)
    if fill_params
        return substitute(tmp)
    else
        return tmp
    end
end


function Symbolics.substitute(xc::T) where T<: AbstractFunctional
    tmp = substitute( xc.xc, xc.parameters )
    dtmp = map( x->substitute(x, xc.parameters), xc.derivatives )
    return T( tmp, xc.parameters, dtmp)
end

function generate_functional_derivatives!(xc::AbstractFunctional, derivative::Int)
    D = Differential(ρ)
    for i in length(xc.derivatives):derivative-1
        if i == 0
            tmp = D( xc.xc )
        else
            tmp = D( xc.derivatives[end] )
        end
        push!( xc.derivatives, expand_derivatives(tmp) )
    end
end


# Used to build functionals
function sub_functional(name)
    xc = generate_functional(name; fill_params=true)
    return xc.xc
end



function build_functional(xc::LdaFunctional; compile=false, target=JuliaTarget())
    tmp = substitute(xc)
    out = Dict{Int, Any}()
    out[0] = build_function(tmp.xc, ρ; expression = Val{!compile}, target=target)
    for i in eachindex(tmp.derivatives)
        out[i] = build_function(tmp.derivatives[i], ρ; expression = Val{!compile}, target=target)
    end
    return out
end

function build_functional(xc::GgaFunctional; compile=false, target=JuliaTarget())
    tmp = substitute(xc)
    out = Dict{Int, Any}()
    out[0] = build_function(tmp.xc, ρ, σ; expression = Val{!compile}, target=target)
    for i in eachindex(tmp.derivatives)
        out[i] = build_function(tmp.derivatives[i], ρ, σ; expression = Val{!compile}, target=target)
    end
    return out
end


function build_functional(name::AbstractString, derivatives::Int...; compile=false, target=JuliaTarget())
    @argcheck all( derivatives .> 0 )
    xc = generate_functional(name)
    generate_functional_derivatives!(xc, maximum(derivatives))
    tmp = build_functional(xc; compile=compile, target=target)
    t = (0, derivatives...)
    return Dict( k=>v for (k,v) in pairs(tmp) if k in t )
end
