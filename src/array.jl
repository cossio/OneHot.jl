"""
    OneHotArray

A type to hold a one-hot encoded array efficiently.
Implements efficient matrix multiplication.
"""
struct OneHotArray{N,A} <: AbstractArray{Bool,N}
    c::A
    q::Int
    function OneHotArray(c::Union{Int, AbstractArray{Int}}, q::Int = maximum(c))
        if !all(1 ≤ x ≤ q for x in c)
            throw(ArgumentError("c must be ≥ 1 and ≤ $q; got $x"))
        end
        return new{ndims(c) + 1, typeof(c)}(c, q)
    end
end

OneHotArray(X::AbstractArray{Bool}) = OneHotArray(decode(X))
OneHotArray(X::OneHotArray) = X

Base.size(a::OneHotArray) = (a.q, size(a.c)...)

@inline function Base.getindex(a::OneHotArray{N}, i::Vararg{Int,N}) where {N}
    @boundscheck checkbounds(a, i...)
    return @inbounds first(i) == a.c[tail(i)...]
end

@inline function Base.getindex(a::OneHotArray, ::Colon, i...)
    @boundscheck checkbounds(a.c, i...)
    return @inbounds OneHotArray(a.c[i...], a.q)
end

const OneHotVector = OneHotArray{1,Int}
const OneHotMatrix = OneHotArray{2,Vector{Int}}
const OneHotVecOrMat = Union{OneHotVector, OneHotMatrix}

function Base.:*(A::AbstractMatrix, B::OneHotVecOrMat)
    if size(A, 2) ≠ size(B, 1)
        throw(DimensionMismatch("A has dimensions $(size(A)) but B has dimensions $(size(B))"))
    end
    return A[:, B.c]
end
