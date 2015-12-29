function (+){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
    aLoIsOpen, aHiIsOpen = bounds(B1)
    bLoIsOpen, bHiIsOpen = bounds(B2)

    newBound = bound( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

    lo = (+)(a.lo, b.lo) #  RoundDown
    hi = (+)(a.hi, b.hi) #  RoundUp

    Ivl{newBound}(lo, hi)
end

