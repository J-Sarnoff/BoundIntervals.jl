# BoundedRealIntervals.jl
Extended Real Intervals with bounds that are Open, Closed or Mixed
```julia

#=
Intervals are created using ClCl(lo,hi), ClOp(lo,hi), OpCl(lo,hi), OpOp(lo,hi)
   lo, hi must be subtypes of Real
   lo and hi may differ in specific type, the types will persist
   lo,hi are sorted internally to ensure lo<=hi **bounds will swap if values swap**
=#
julia> ClOp(2,5), OpCl(5,2)  # if values are given hi,lo the bounds will be swapped
ClOp(2,5), ClOp(2,5)         # for programming, there is a way to bypass swapping bounds 
