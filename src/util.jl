"""
    argmaxdrop(A; dims)

Index of maximum elements of `A` over given `dims`, dropping the reduced `dims`.
"""
function argmaxdrop(A::AbstractArray; dims)
	indices = argmax(A; dims=dims)
	dropdims(indices; dims=dims)
end

"""
    argmaxdropfirst(A, Val(N) = Val(1))

argmax of `A` over its first `N` dimensions and drops them. By default `N = 1`.
"""
function argmaxdropfirst(A::AbstractArray, ::Val{N} = Val(1)) where {N}
	dims = ntuple(Val(N))
	argmaxdrop(A; dims=dims)
end

function softmax(xs::AbstractArray; dims=1)
    max_ = maximum(xs, dims=dims)
    exp_ = exp.(xs .- max_)
    exp_ ./ sum(exp_, dims=dims)
end

"""
	columns(A)

Returns an array over the columns of `A` (as views). Similar to `eachcol` but
for higher-dimensional arrays.
"""
function columns(A::AbstractArray)
	[A[:,I] for I in CartesianIndices(axes(A)[2:end])]
end

"""
	ntuple(Val(N))

Constructs the tuple `(1, 2, ..., N)`.
"""
@generated Base.ntuple(::Val{N}) where {N} = ntuple(identity, Val(N))
