"""
    tensormul(A, B, dims)

`A*B` contracting first `dims` dimensions of `A` with first `dims` dimensions of `B`
(which must match). Exploits the fact that some of the tensors are `OneHotArray`.
"""
tensormul(A::AbstractArray, B::AbstractArray, dims::Int) = tensormul(A, B, Val(dims))

function tensormul(A::OneHotArray, B::AbstractArray, ::Val{dims}) where {dims}
    dims::Int
    @assert size(A)[1:dims] == size(B)[1:dims]
    C = [
        sum(B[A.c[k, i], k, j] for k in CartesianIndices(size(A)[2:dims])) for
        i in CartesianIndices(size(A)[(dims + 1):end]),
        j in CartesianIndices(size(B)[(dims + 1):end])
    ]
    @assert size(C) == (size(A)[(dims + 1):end]..., size(B)[(dims + 1):end]...)
	return C
end

function tensormul(A::OneHotArray, B::OneHotArray, ::Val{dims}) where {dims}
    dims::Int
    @assert size(A)[1:dims] == size(B)[1:dims]
    C = [
        sum(B[A.c[k, i], k, j] for k in CartesianIndices(size(A)[2:dims])) for
        i in CartesianIndices(size(A)[(dims + 1):end]),
        j in CartesianIndices(size(B)[(dims + 1):end])
    ]
    @assert size(C) == (size(A)[(dims + 1):end]..., size(B)[(dims + 1):end]...)
	return C
end

function tensormul(A::AbstractArray, B::OneHotArray, ::Val{dims}) where {dims}
    dims::Int
    @assert size(A)[1:dims] == size(B)[1:dims]
    C = [
        sum(A[B.c[k, j], k, i] for k in CartesianIndices(size(B)[2:dims])) for
        i in CartesianIndices(size(A)[(dims + 1):end]),
        j in CartesianIndices(size(B)[(dims + 1):end])
    ]
    @assert size(C) == (size(A)[(dims + 1):end]..., size(B)[(dims + 1):end]...)
	return C
end
