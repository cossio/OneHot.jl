using Documenter, Literate
using OneHot

function clear_md_files(dir::String)
    for file in readdir(dir; join=true)
        if endswith(file, ".md")
            rm(file)
        end
    end
end

const literate_dir = joinpath(@__DIR__, "src/literate")
clear_md_files(literate_dir)

for file in readdir(literate_dir; join=true)
    if endswith(file, ".jl")
        Literate.markdown(file, literate_dir)
    end
end

makedocs(
    sitename = "OneHot",
    modules = [OneHot],
    pages = [
        "Home" => "index.md",
        "Examples" => [
            "Matrix multiplication" => "literate/matmul.md"
        ],
        "Reference" => "reference.md"
    ],
    strict = true
)

deploydocs(
    repo = "github.com/cossio/OneHot.jl.git",
    devbranch = "master"
)
