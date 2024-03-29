"""
    argmax_(A; dims)

Index of maximum elements of `A` over given `dims`, dropping the reduced `dims`.
"""
function argmax_(A::AbstractArray; dims)
    indices = argmax(A; dims=dims)
    return dropdims(indices; dims=dims)
end

"""
    encode(data, labels)

Returns a one-hot encoded version of `data`, where classes are indexed according
to `labels`.
"""
function encode(data::AbstractArray, labels = sort(unique(data)))
    return reshape(data, 1, size(data)...) .== labels
end

"""
    decode(X)

Returns an array `A` such that `OneHot.encode(A, 1:q) == X`.
Here `q = size(X, 1)` is interpreted as the number of classes.
"""
function decode(X::AbstractArray)
    I = argmax_(X; dims=1)
    return first.(Tuple.(I))
end

decode(X::OneHotArray) = X.c
