abstract type AbstractFunctional end

struct LdaFunctional <: AbstractFunctional
    xc::Num
    parameters::Dict{Num, Any}
    derivatives::Vector{Num}
end

struct GgaFunctional <: AbstractFunctional
    xc::Num
    parameters::Dict{Num, Any}
    derivatives::Vector{Num}
end

function Functional(xc, info::Dict)
    if info["type"] == :lda
        return LdaFunctional(xc, info["parameters"],[])
    elseif info["type"] == :gga
        return GgaFunctional(xc, info["parameters"],[])
    else
        error("not implemented yet")
    end
end



function Base.show(io::IO, ::MIME"text/plain", ::LdaFunctional)
    print(io, "LDA functional")
end

function Base.show(io::IO, ::MIME"text/plain", ::GgaFunctional)
    print(io, "GGA functional")
end


function Base.print(io::IO, xc::AbstractFunctional)
    print(io, xc.xc)
end

