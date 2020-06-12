struct OneHotArray{N,A} <: AbstractArray{Bool,N}
    c::A   # classes
    q::Int # number of classes
    function OneHotArray{N,A}(c::A, q::Int) where {N,A<:Union{Int64,AbstractArray{Int64}}}
        N === ndims(c) + 1 || throw(DimensionMismatch("N must be $(ndims(c) + 1); got N = $N"))
        for x in c
            x::Int
            1 ≤ x ≤ q || throw(ArgumentError("classes must be ∈ [1,$q]; got $x"))
        end
        new{N,A}(c, q)
    end
end
OneHotArray(c, q = maximum(c)) = OneHotArray{ndims(c) + 1, typeof(c)}(c, q)
Base.size(a::OneHotArray) = (a.q, size(a.c)...)

@inline function Base.getindex(a::OneHotArray{N}, i::Int...) where {N}
    @boundscheck checkbounds(a, i...)
    @inbounds first(i) == a.c[tail(i)...]
end
@inline function Base.getindex(a::OneHotArray, ::Colon, i...) where {N_}
    @boundscheck checkbounds(a.c, i...)
    @inbounds OneHotArray(a.c[i...], a.q)
end

OneHotVector = OneHotArray{1,Int}
OneHotMatrix = OneHotArray{2,Vector{Int}}
OneHotVecOrMat = Union{OneHotVector, OneHotMatrix}

function Base.:*(A::AbstractMatrix, B::OneHotVecOrMat)
    if size(A,2) ≠ size(B,1)
        throw(DimensionMismatch("A has dimensions $(size(A)) but B has dimensions $(size(B))"))
    end
    return A[:, B.c]
end

decode(X::OneHotArray) = X.c
