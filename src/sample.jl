import Random: GLOBAL_RNG, AbstractRNG

export sample, sample_from_logits

"""
	sample([rng=GLOBAL_RNG], P)

Given a probability array `P` of size `(q, *)`, returns an array
`X` of the same size as `P`, whose columns `X[:,*]` are one-hot encoded random
samples from the categorical distribution `P[:,*]`.
"""
function sample(rng::AbstractRNG, P::AbstractArray)
    q = size(P, 1)
    result = falses(size(P))
	pcols = columns(P)
    for i in CartesianIndices(pcols)
		ps = pcols[i]
		a = categorical_rand(rng, ps)
        result[a, i] = 1
    end
    return result
end
sample(p::AbstractArray) = sample(GLOBAL_RNG, p)

"""
	sample_from_logits([rng=GLOBAL_RNG], logits)

Given a logits array `logits` of size `(num_classes, *)`, returns an array
`R` of the same size as `logits`, whose columns `R[:,*]` are one-hot encoded
random samples from the categorical distribution with logits `logits[:,*]`.
"""
function sample_from_logits(rng::AbstractRNG, logits::AbstractArray)
	p = softmax(logits)
	sample(rng, p)
end
sample_from_logits(logits::AbstractArray) = sample_from_logits(GLOBAL_RNG, logits)

"""
	categorical_rand([rng=GLOBAL_RNG], ps)

Randomly draw `i` with probability `ps[i]`.
"""
function categorical_rand(rng::AbstractRNG, ps)
	i = 0
	u = rand()
	for p in ps
		u -= p
		i += 1
		u ≤ 0 && break
	end
	return i
end
categorical_rand(ps) = categorical_rand(GLOBAL_RNG, ps)
