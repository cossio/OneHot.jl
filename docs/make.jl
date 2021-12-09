using Documenter
using OneHot

makedocs(
    sitename = "OneHot",
    modules = [OneHot]
)

deploydocs(
    repo = "github.com/cossio/OneHot.jl.git",
    devbranch = "master"
)
