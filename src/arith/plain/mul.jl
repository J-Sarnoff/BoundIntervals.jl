#=
    There are nine general cases for processing a*b
                   b <= 0    b <0< b    b >= 0
       a <=  0    LteLte      LteZer    LteGte
       a <0< a    ZerLte      ZerZer    ZerGte
       a >=  0    GteLte      GteZer    GteGte
=#

function (*){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
    z = zero(typeof(a.hi))
    if     a.hi <= z
       if     b.hi <= z
           mulLteLte(a,b)
       elseif b.lo >= z
           mulLteGte(a,b)
       else   # b straddles 0
           mulLteZer(a,b)
       end
    elseif a.lo >= z
       if     b.hi <= z
           mulGteLte(a,b)
       elseif b.lo >= z
           mulGteGte(a,b)
       else   # b straddles 0
           mulGteZer(a,b)
       end
    else   # a straddles 0
       if     b.hi <= z
           mulZerLte(a,b)
       elseif b.lo >= z
           mulZerGte(a,b)
       else   # b straddles 0
           mulZerZer(a,b)
       end
    end
end

for (fn,loa,lob,hia,hib) in [ (:mulLteLte, :(a.hi), :(b.hi), :(a.lo), :(b.lo)),
                              (:mulLteGte, :(a.lo), :(b.hi), :(a.hi), :(b.lo)),
                              (:mulLteZer, :(a.lo), :(b.hi), :(a.lo), :(b.lo)),
                              (:mulGteLte, :(a.hi), :(b.lo), :(a.lo), :(b.hi)),
                              (:mulGteGte, :(a.lo), :(b.lo), :(a.hi), :(b.hi)),
                              (:mulGteZer, :(a.hi), :(b.lo), :(a.hi), :(b.hi)),
                              (:mulZerLte, :(a.hi), :(b.lo), :(a.lo), :(b.lo)),
                              (:mulZerGte, :(a.lo), :(b.hi), :(a.hi), :(b.hi)),
                            ]
  @eval begin
    function ($fn){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
        aLoIsOpen, aHiIsOpen = bounds(B1)
        bLoIsOpen, bHiIsOpen = bounds(B2)
        newBound = bound( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

        lo = (*)(($loa), ($lob))
        hi = (*)(($hia), ($hib))

        Ivl{newBound}(lo, hi)
    end
  end
end

function mulZerZer{B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2})
        aLoIsOpen, aHiIsOpen = bounds(B1)
        bLoIsOpen, bHiIsOpen = bounds(B2)
        newBound = bound( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

        lo = min( (*)(a.lo, b.hi), (*)(a.hi, b.lo) )
        hi = max( (*)(a.lo, b.lo), (*)(a.hi, b.hi) )
        
        Ivl{newBound}(lo,hi)
end

