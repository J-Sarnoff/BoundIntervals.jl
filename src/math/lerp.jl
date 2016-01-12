#=
ref: Computer graphics, linear interpolation, and nonstandard intervals
     Arnold Neumaier, 2009
     http://www.mat.univie.ac.at/~neum/ms/nonstandard.pdf

given two intervals x,y and an interval valued linear interpolant t in [0,1]

      lerp(x,y,t) is (1-t)*x + t*y
=#

function lerp{B1<:AkoBound,B2<:AkoBound,B3<:AkoBound}(x::Ivl{B1}, y::Ivl{B2}, t::Ivl{B3})
    xLoIsOpen, xHiIsOpen = bounds(B1)
    yLoIsOpen, yHiIsOpen = bounds(B2)
    tLoIsOpen, tHiIsOpen = bounds(B3)

    newBound = bound( (xLoIsOpen|yLoIsOpen|tLoIsOpen), (xHiIsOpen|yHiIsOpen|tHiIsOpen) )

    # each value can be of a different type
    T = promote_type(promote_type(typeof(x.lo),typeof(y.lo)),promote_type(typeof(x.hi),typeof(y.hi)))
    T = promote_type(promote_type(T,typeof(t.lo)),typeof(t.hi))
    lo=hi=zero(T)
    
    with_rounding(T,RoundDown) do
       dlo = y.lo - x.lo
       tlo = (dlo >= 0 ? t.lo : t.hi)
       lo = x.lo + tlo*dlo
    end
    with_rounding(T, RoundUp) do
       dhi = y.hi - x.hi
       thi = (dhi >= 0 ? t.hi : t.lo)
       hi = x.hi + thi*dhi
    end   

    Ivl{newBound}(lo, hi)
end
