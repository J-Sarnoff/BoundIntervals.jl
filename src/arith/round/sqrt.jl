function sqrt{B<:AkoBound}(a::Ivl{B})
    T = promote_type(typeof(a.lo),typeof(a.hi))
    lo=hi=zero(T)
    
    with_rounding(T,RoundDown) do
        lo = sqrt(a.lo)
    end
    with_rounding(T,RoundUp) do
        hi = sqrt(a.hi)
    end
    
    Ivl{B}(lo, hi)
end
