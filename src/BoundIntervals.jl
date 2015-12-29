module BoundIntervals

import Base: convert, promote_type,
    string, hash, show, showcompact,
    sign, copysign, flipsign, abs,
    (==),(!=),(<=),(<),(>),(>=),isequal,isless,
    (+),(-),(*),(/),sqrt,hypot
    
export ClCl, ClOp, OpCl, OpOp, Xact,
       clcl, clop, opcl, opop,
       sqr
    
include("type/abstract.jl")
include("type/concrete.jl")
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


end # module
