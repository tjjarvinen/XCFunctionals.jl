using XCFunctionals
using Documenter

DocMeta.setdocmeta!(XCFunctionals, :DocTestSetup, :(using XCFunctionals); recursive=true)

makedocs(;
    modules=[XCFunctionals],
    authors="Teemu Järvinen <teemu.j.jarvinen@gmail.com> and contributors",
    repo="https://github.com/tjjarvinen/XCFunctionals.jl/blob/{commit}{path}#{line}",
    sitename="XCFunctionals.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://tjjarvinen.github.io/XCFunctionals.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Tutorial" => "tutorial.md"
    ],
)

deploydocs(;
    repo="github.com/tjjarvinen/XCFunctionals.jl",
    devbranch="main",
)
