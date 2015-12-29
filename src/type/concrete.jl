# bounded extended real intervals with open/closed/mixed bounds

# allow lo, hi to differ in type (subtypes of Real)
# R <-- promote_type(typeof(lo),typeof(hi))

immutable Ivl{B<:AkoBound}  <: RealInterval
    lo::Real                        
    hi::Real
end


