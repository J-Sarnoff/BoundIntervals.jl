module BoundedRealIntervals

import Base: convert, promote_type,
    string, hash, show, showcompact,
    sign, changesign, flipsign, abs,
    (+),(-),(*),(/),sqrt,hypot
    
export ClCl, ClOp, OpCl, OpOp,
       clcl, clop, opcl, opop,
       sqr
    
include("type/abstract.jl")
include("type/concrete.jl")
include("type/enfold.jl")
include("type/io.jl")

if isdefined(Main,:UseRounding) && (Main.UseRounding==true)
include("arith/round/add.jl")
include("arith/round/sub.jl")
include("arith/round/mul.jl")
include("arith/round/div.jl")
else
include("arith/plain/add.jl")
include("arith/plain/sub.jl")
include("arith/plain/mul.jl")
include("arith/plain/div.jl")
end # UseRounding


end # module
