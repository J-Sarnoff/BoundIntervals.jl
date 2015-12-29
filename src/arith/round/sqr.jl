function sqr{B<:AkoBound}(a::Ivl{B})
    T = promote_type(typeof(a.lo),typeof(a.hi))
    lo=hi=zero(T)
    
    with_rounding(T,RoundDown) do
        lo = a.lo * a.lo
    end
    with_rounding(T,RoundUp) do
        hi = a.hi * a.hi
    end
    
    Ivl{B}(lo, hi)
end
