module BoundedRealIntervals

import Base: convert, promote_type,
    string, hash, show, showcompact,
    sign, changesign, flipsign, abs
    
    
include("type/abstract.jl")
include("type/concrete.jl")

end # module
