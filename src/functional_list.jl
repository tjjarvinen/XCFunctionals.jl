
function list_functionals(io::IO, name_includes)
    for xc in sort(list_of_functionals)
        if occursin(name_includes, xc)
            println(io, xc)
        end
    end
end

function list_functionals(name_includes="")
    list_functionals(stdout, name_includes)
end


const list_of_functionals = [
    # LDA
    "lda_example",

    # GGA
    "gga_example"
]