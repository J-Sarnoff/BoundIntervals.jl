# BoundIntervals.jl
Extended Real Intervals with bounds that are Open, Closed or Mixed

Some types of values do not support rounding (Rational{Int64}, for example). Others do, e.g. Float64.

>   Set __UseRounding=true__ before 'using' this module, if you want interval math with directed rounding.  
>   Otherwise, all interval arithmetic will be performed using the default, RoundNearest mode.


```julia

#=
Intervals are created using ClCl(lo,hi), ClOp(lo,hi), OpCl(lo,hi), OpOp(lo,hi)
   lo, hi must be subtypes of Real
   lo and hi may differ in specific type, the types will persist
   lo,hi are sorted internally to ensure lo<=hi **bounds will swap if values swap**
=#
julia> ClOp(2,5), OpCl(5,2)  # if values are given hi,lo the bounds will be swapped
ClOp(2, 5), ClOp(2, 5)

julia> clop(2,5), opcl(5,2)  #  for programming, lowercased they sort but do not swap bounds
ClOp(2, 5), OpCl(2, 5)

# intervals may be bounds converted, maintaining enclosure
julia> ClOp(ClCl(1.0f0,2.0f0)), OpCl(ClCl(1.0f0,2.0f0)), ClCl(OpOp(1.0f0,2.0f0))
ClOp(2.0f0, 1.0000001f0), OpCl(1.9999999f0, 1.0f0), ClCl(1.0f0, 2.0f0)

# for programming, bounds may be converted without altering the bounding values
julia> clop(ClCl(1.0f0,2.0f0)), opcl(ClCl(1.0f0,2.0f0)), clcl(OpOp(1.0f0 2.0f0))
ClOp(1.0f0, 2.0f0), OpCl(1.0f0, 2.0f0), ClCl(1.0f0, 2.0f0)

# ordering
julia> ClOp(1.0) < OpCl(1.0), OpOp(1.0,2.0) != OpCl(1.0,2.0)
true, true

# arithmetic
julia> ClOp(1.0)+ClOp(2.0,3.0), sqrt(OpCl(2.0,3.0)), OpCl(9.0,12.0)/ClOp(2.0,3.0)
ClOp(3.0, 4.0), OpCl(1.4142135623730951, 1.7320508075688772), OpOp(3.0, 6.0)
