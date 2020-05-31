"""
	classify(scores)

Given an array of `scores`, where the first dimension corresponds to different
categories, returns arrays of categories (index along first dimension) of
highest score.
"""
function classify(scores::AbstractArray)
	cindices = argmaxdropfirst(scores)
	first.(Tuple.(cindices))
end

"""
	entropy(X)

Given a one-hot array `X` of size `(q,*)`, where `q` is the number
of classes and `*` are batch dimensions, computes the entropy.
"""
function entropy(X::AbstractArray)
	bdims = Base.tail(tuplen(Val(ndims(X))))
	C = sum(X; dims=bdims)
	p = C ./ sum(C)
	return -sum(xlogx.(p))
end
