export sample, sample_from_logits

"""
    sample([rng=Random.GLOBAL_RNG], P)

Given a probability array `P` of size `(q, *)`, returns an array
`X` of the same size as `P`, whose columns `X[:,*]` are one-hot encoded random
samples from the categorical distribution `P[:,*]`.
"""
function sample(rng::AbstractRNG, P::AbstractArray)
    q = size(P, 1)
    colind = CartesianIndices(tail(size(P)))
    c = Array{Int}(undef, tail(size(P)))
    @inbounds for i in colind
        ps = @view P[:,i]
        c[i] = categorical_rand(rng, ps)
    end
    return OneHotArray(c, q)
end
sample(p::AbstractArray) = sample(Random.GLOBAL_RNG, p)

"""
    sample_from_logits([rng=Random.GLOBAL_RNG], logits)

Given a logits array `logits` of size `(num_classes, *)`, returns an array
`R` of the same size as `logits`, whose columns `R[:,*]` are one-hot encoded
random samples from the categorical distribution with logits `logits[:,*]`.
"""
function sample_from_logits(rng::AbstractRNG, logits::AbstractArray)
    p = softmax(logits)
    return sample(rng, p)
end
sample_from_logits(logits::AbstractArray) = sample_from_logits(Random.GLOBAL_RNG, logits)

"""
    categorical_rand([rng=Random.GLOBAL_RNG], ps)

Randomly draw `i` with probability `ps[i]`.
"""
function categorical_rand(rng::AbstractRNG, ps::AbstractVector)
    i = 0
    u = rand(rng)
    for p in ps
        u -= p
        i += 1
        u ≤ 0 && break
    end
    return i
end
categorical_rand(ps::AbstractVector) = categorical_rand(Random.GLOBAL_RNG, ps)

"""
    sample_from_logits_gumbel([rng=Random.GLOBAL_RNG], logits)

Like sample_from_logits, but using the Gumbel trick.
"""
function sample_from_logits_gumbel(rng::AbstractRNG, logits::AbstractArray)
    z = logits .+ randgumbel.(rng, float(eltype(logits)))
    c = classify(z)
    return OneHotArray(c, size(logits, 1))
end

function sample_from_logits_gumbel(logits::AbstractArray)
    return sample_from_logits_gumbel(Random.GLOBAL_RNG, logits)
end

"""
    randgumbel(rng = Random.GLOBAL_RNG, T = Float64)

Generates a random Gumbel variate.
"""
randgumbel(rng::AbstractRNG, ::Type{T} = Float64) where {T} = -log(randexp(rng, T))
randgumbel(::Type{T} = Float64) where {T} = randgumbel(Random.GLOBAL_RNG, T)
