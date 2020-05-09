"""
	classify(scores)

Given an array of `scores`, where the first dimension corresponds to different
categories, returns arrays of categories (index along first dimension) of
highest score.
"""
function classify(scores::AbstractArray)
	cindices = argmaxdropfirst(A)
	first.(Tuple.(cindices))
end
