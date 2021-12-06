"""
    encode(A, q)

Takes an integer array `A` of size (*) and returns a BitArray of shape
`(q, *)` that has zeros everywhere, except at the positions (A[*], *) which
have ones. If not given `q` (the number of classes) defaults to maximum(A).
This is similar to the PyTorch function (but column-major):
    https://pytorch.org/docs/stable/nn.functional.html#one-hot.
"""
encode(A::AbstractArray{<:Integer}, q::Integer = maximum(A)) = OneHotArray(A, q)

"""
    decode(X)

Takes a binary array `X` of size (q, *) and returns an integer array `A` of
size (*) such that `OneHot.encode(A, q) == X`.
"""
function decode(X::AbstractArray)
    I = argmaxdrop(X; dims=1)
    return first.(Tuple.(I))
end
