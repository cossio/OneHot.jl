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
    dims = tuplen(Val(N))
    argmaxdrop(A; dims=dims)
end

function softmax(xs::AbstractArray; dims=1)
    max_ = maximum(xs, dims=dims)
    exp_ = exp.(xs .- max_)
    return exp_ ./ sum(exp_, dims=dims)
end

function softmax_online(x::AbstractArray) # seems slower than softmax
    max_ = fill(convert(eltype(x), -Inf), 1, tail(size(x))...)
    sum_ = zeros(eltype(x), 1, tail(size(x))...)
    for j in CartesianIndices(tail(size(x))), i = 1:size(x,1)
        if x[i,j] > max_[1,j]
            sum_[1,j] *= exp(max_[1,j] - x[i,j])
            max_[1,j] = x[i,j]
        end
        sum_[1,j] += exp(x[i,j] - max_[1,j])
    end
    exp_ = exp.(x .- max_)
    return exp_ ./ sum_
end

"""
    columns(A)

Returns an array over the columns of `A` (as views). Similar to `eachcol` but
for higher-dimensional arrays. In general column (i,j,k,...) is defined as
`A[:,i,j,k,...]`.
"""
function columns(A::AbstractArray)
    [A[:,I] for I in CartesianIndices(Base.tail(axes(A)))]
end

"""
    tuplen(Val(N))

Constructs the tuple `(1, 2, ..., N)`.
"""
@generated tuplen(::Val{N}) where {N} = ntuple(identity, Val(N))

function xlogx(x::Number)
    result = x * log(x)
    return ifelse(iszero(x), zero(result), result)
end
