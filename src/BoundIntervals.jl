module BoundIntervals

import Base: convert, promote_rule, promote_type,
    string, hash, show, showcompact,
    sign, copysign, flipsign, abs,
    (==),(!=),(<=),(<),(>),(>=),isequal,isless,
    (+),(-),(*),(/),sqrt,hypot,
    exp, expm1, log, log1p,
    sin, cos, tan, csc, sec, cot,
    asin, acos, atan, acsc, asec, acot,
    sinh, cosh, tanh, csch, sech, coth,
    asinh, acosh, atanh, acsch, asech, acoth,
    erf, erfinv
    
export ClCl, ClOp, OpCl, OpOp, Xact,
       clcl, clop, opcl, opop,
       sqr, lerp, normalize
    
include("type/abstract.jl")

if isdefined(Main,:OnlyRealTypes) && (Main.OnlyRealTypes==true)
include("type/concrete.jl")
else
include("type/concretion.jl")
end

include("type/enfold.jl")
include("type/convert.jl")
include("type/compare.jl")
include("type/io.jl")

if isdefined(Main,:UseRounding) && (Main.UseRounding==true)
include("arith/round/add.jl")
include("arith/round/sub.jl")
include("arith/round/mul.jl")
include("arith/round/div.jl")
include("arith/round/sqrt.jl")
include("arith/round/sqr.jl")
else
include("arith/plain/add.jl")
include("arith/plain/sub.jl")
include("arith/plain/mul.jl")
include("arith/plain/div.jl")
include("arith/plain/sqrt.jl")
include("arith/plain/sqr.jl")
end # UseRounding

include("math/unaryfuncs.jl")
include("math/lerp.jl")
include("math/normalize.jl")

end # module
