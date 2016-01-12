#=
ref:  Improving interval enclosures
      Arnold Neumaier, 2015
      http://www.mat.univie.ac.at/~neum/ms/encl.pdf

      interval valued x,y,z
      
      (x,y)   --> x/sqrt(x^2 + y^2), y/sqrt(x^2 + y^2)
      (x,y,z) --> x/sqrt(x^2 + y^2 + z^2), y/sqrt(x^2 + y^2 + z^2), z/sqrt(x^2 + y^2 + z^2)
=#


function normalize{B1<:AkoBound,B2<:AkoBound}(x::Ivl{B1}, y::Ivl{B2})
    xLoIsOpen, xHiIsOpen = bounds(B1)
    yLoIsOpen, yHiIsOpen = bounds(B2)

    newBound = bound( (xLoIsOpen|yLoIsOpen), (xHiIsOpen|yHiIsOpen) )

    # each value can be of a different type
    T = promote_type(promote_type(typeof(x.lo),typeof(y.lo)),promote_type(typeof(x.hi),typeof(y.hi)))
    xx=yy=zero(T)
    
    x2 = sqr(x)
    y2 = sqr(y)

    lo = x.lo / sqrt(x.lo*x.lo + y2.hi)
    hi = x.hi / sqrt(x.hi*x.hi + y2.lo)
    xx = Ivl{newBound}(lo,hi)
    
    lo = y.lo / sqrt(y.lo*y.lo + x2.hi)
    hi = y.hi / sqrt(y.hi*y.hi + x2.lo)
    yy = Ivl{newBound}(lo,hi)

    (xx, yy)
end

function normalize{B1<:AkoBound,B2<:AkoBound,B3<:AkoBound}(x::Ivl{B1}, y::Ivl{B2}, z::Ivl{B3})
    xLoIsOpen, xHiIsOpen = bounds(B1)
    yLoIsOpen, yHiIsOpen = bounds(B2)
    zLoIsOpen, zHiIsOpen = bounds(B3)

    newBound = bound( (xLoIsOpen|yLoIsOpen|zLoIsOpen), (xHiIsOpen|yHiIsOpen|zHiIsOpen) )

    # each value can be of a different type
    T = promote_type(promote_type(typeof(x.lo),typeof(y.lo)),promote_type(typeof(x.hi),typeof(y.hi)))
    T = promote_type(promote_type(T,typeof(z.lo)),typeof(z.hi))
    xx=yy=zz=zero(T)
    
    x2 = sqr(x)
    y2 = sqr(y)
    z2 = sqr(z)
    
    w = y2 + z2
    
    lo = x.lo / sqrt(x.lo*x.lo + w.hi)
    hi = x.hi / sqrt(x.hi*x.hi + w.lo)
    xx = Ivl{newBound}(lo,hi)
    
    w = x2 + z2
    
    lo = y.lo / sqrt(y.lo*y.lo + w.hi)
    hi = y.hi / sqrt(y.hi*y.hi + w.lo)
    yy = Ivl{newBound}(lo,hi)
    
    w = x2 + y2
    
    lo = z.lo / sqrt(z.lo*z.lo + w.hi)
    hi = z.hi / sqrt(z.hi*z.hi + w.lo)
    zz = Ivl{newBound}(lo,hi)
    
    (xx,yy,zz)
end


