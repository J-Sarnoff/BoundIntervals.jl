function (+){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
    aLoIsOpen, aHiIsOpen = bounds(B1)
    bLoIsOpen, bHiIsOpen = bounds(B2)

    newBound = bound( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

    # each value can be of a different type
    T = promote_type(promote_type(typeof(a.lo),typeof(b.lo)),promote_type(typeof(a.hi),typeof(b.hi)))
    lo=hi=zero(T)
    
    with_rounding(T,RoundDown) do
       lo = (+)(a.lo, b.lo)
    end
    with_rounding(T, RoundUp) do
       hi = (+)(a.hi, b.hi)
    end   

    Ivl{newBound}(lo, hi)
end

