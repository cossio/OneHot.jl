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
