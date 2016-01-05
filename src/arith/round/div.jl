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
    z = zero(typeof(b.lo))
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

        # each value can be of a different type
        T = promote_type(promote_type(typeof(a.lo),typeof(b.lo)),promote_type(typeof(a.hi),typeof(b.hi)))
        lo=hi=zero(T)
    
        with_rounding(T,RoundDown) do
            lo = (/)(($loa), ($lob))
        end
        with_rounding(T,RoundUp) do
            hi = (/)(($hia), ($hib))
        end    

        Ivl{newBound}(lo, hi)
    end
  end
end


function divisorContainsZero{B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
    aLoIsOpen, aHiIsOpen = bounds(B1)
    bLoIsOpen, bHiIsOpen = bounds(B2)
    newBound = bound( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

    z = zero(typeof(b.lo))
    if (b.lo < z) & (b.hi > z)
       return divisorStraddlesZero(a,b)
    end
    
    # each value can be of a different type
    T = promote_type(promote_type(typeof(a.lo),typeof(b.lo)),promote_type(typeof(a.hi),typeof(b.hi)))
    lo=hi=zero(T)
    
    if b.lo == zero(T)
       with_rounding(T,RoundDown) do    
           lo = one(T) / b.hi
       end     
       hi = (T)(Inf)
    else b.hi == zero(T)
       lo = (T)(-Inf)
       with_rounding(T,RoundUp) do
           hi = one(T) / b.lo
       end
    end

    Ivl{newBound}(lo, hi)
end

function divisorStraddlesZero{B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
    ErrorException("Divisor straddles zero: $(a) / $(b)")
end
