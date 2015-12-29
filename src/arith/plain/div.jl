#=
    There are six general cases for processing a/b (when b excludes 0)
    and six special cases (where the denominator includes 0 as a bound)
    and two exceptional cases (where the denominator is 0 or straddles 0)
                  b <= 0       b >= 0
       a <=  0    LteLte       LteGte
       a <0< a    ZerLte       ZerGte
       a >=  0    GteLte       GteGte
=#

function (/){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
    z = zero(R)
    if (b.lo == z) | (b.hi == z) | ((b.lo < z) & (b.hi > z))
      divisorContainsZero(a,b)
   elseif a.hi <= z
       if     b.hi <= z
           divLteLte(a,b)
       else # b.lo.fp >= z
           divLteGte(a,b)
       end
   elseif a.lo >= z
       if     b.hi <= z
           divGteLte(a,b)
       else # b.lo >= 0
           divGteGte(a,b)
       end
   else   # a straddles 0
       if     b.hi <= z
           divZerLte(a,b)
       else # b.lo >= 0
           divZerGte(a,b)
       end
   end
end

for (fn,loa,lob,hia,hib) in [ (:divLteLte, :(a.hi), :(b.lo), :(a.lo), :(b.hi)),
                              (:divLteGte, :(a.lo), :(b.lo), :(a.hi), :(b.hi)),
                              (:divGteLte, :(a.hi), :(b.hi), :(a.lo), :(b.lo)),
                              (:divGteGte, :(a.lo), :(b.hi), :(a.hi), :(b.lo)),
                              (:divZerLte, :(a.hi), :(b.hi), :(a.lo), :(b.hi)),
                              (:divZerGte, :(a.lo), :(b.lo), :(a.hi), :(b.lo)),
                            ]
  @eval begin
    function ($fn){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
        aLoIsOpen, aHiIsOpen = bounds(B1)
        bLoIsOpen, bHiIsOpen = bounds(B2)
        newBound = bound( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

        lo = (/)(($loa), ($lob))
        hi = (/)(($hia), ($hib))

        Ivl{newBound}(lo, hi)
    end
  end
end


function divisorContainsZero{B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
    aLoIsOpen, aHiIsOpen = bounds(B1)
    bLoIsOpen, bHiIsOpen = bounds(B2)
    newBound = bound( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

    if (b.lo < zero(R)) & (b.hi > zero(R))
       return divisorStraddlesZero(a,b)
    end   
    if b.lo == zero(R)
       lo = one(R) / b.hi
       hi = (R)(Inf)
    else b.hi == zero(R)
       lo = (R)(-Inf)
       hi = one(R) / b.lo
    end

    Ivl{newBound}(lo, hi)
end

function divisorStraddlesZero{B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
    ErrorException("Divisor straddles zero: $(a) / $(b)")
end
