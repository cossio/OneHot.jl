"""
    encode(A, q)

Takes an integer array `A` of size (*) and returns a BitArray of shape
`(q, *)` that has zeros everywhere, except at the positions (A[*], *) which
have ones. If not given `q` (the number of classes) defaults to maximum(A).
This is similar to the PyTorch function (but column-major):
	https://pytorch.org/docs/stable/nn.functional.html#one-hot.
"""
function encode(A::AbstractArray{<:Integer}, q::Integer = maximum(A))
    X = falses(q, size(A)...)
    for i in CartesianIndices(A)
        X[A[i], i] = true
    end
    return X
end

"""
	decode(X)

Takes a binary array `X` of size (q, *) and returns an integer array `A` of
size (*) such that `onehot_encode(A, q) == X`.
"""
function decode(X::AbstractArray)
	q = size(X, 1)
	A = zeros(Int, ntuple(i -> size(X, i + 1), Val(ndims(X) - 1)))
	for i in CartesianIndices(A)
		for a = 1:q
			if Bool(X[a,i])
				A[i] = a
				break
			end
		end
	end
	return A
end
