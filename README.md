# BoundIntervals.jl
####Extended Real Intervals with bounds that are Open, Closed or Mixed

__This software is scaffolding for experimentation with intervals and for development of interval value types.  Please let me know of things not present, not clear, not ok, not easy to use.__


Some types of values do not support rounding (Rational{Int64}, for example). Others do, e.g. Float64.

>   Set __UseRounding=true__ before 'using' this module, if you want interval math with directed rounding.  
>   Otherwise, all interval arithmetic will be performed using the default, RoundNearest mode.


```julia

#=
Intervals are created using ClCl(lo,hi), ClOp(lo,hi), OpCl(lo,hi), OpOp(lo,hi)
                          (closed-closed, closed-open, open-closed, open-open)
                          
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
julia> clop(ClCl(1.0f0,2.0f0)), opcl(ClCl(1.0f0,2.0f0)), clcl(OpOp(1.0f0,2.0f0))
ClOp(1.0f0, 2.0f0), OpCl(1.0f0, 2.0f0), ClCl(1.0f0, 2.0f0)

# ordering
julia> ClOp(1.0) < OpCl(1.0), OpOp(1.0,2.0) != OpCl(1.0,2.0)
true, true

# arithmetic
julia> ClOp(1.0)+ClOp(2.0,3.0), OpCl(9.0,12.0)/ClOp(2.0,3.0)
ClOp(3.0, 4.0), OpOp(3.0, 6.0)

julia> sqrt(OpCl(2.0,3.0))
  OpCl(1.4142135623730951, 1.7320508075688772)
# OpCl(1.4142135623730950, 1.7320508075688774)  when module loaded with UseRounding=true
```

>  You may instruct the module to accept only values that are a subtype of Real as boundary values.  
>  Set __OnlyRealTypes=true__ before 'using' this module to accomplish that.  
>  Otherwise, you allow the module to accept boundary values from a deeper type palette:

```julia
julia> using BoundIntervals

julia> a=ClOp(1,2);b=ClOp(2,3);c=ClOp(a,b); c, c.hi
ClOp(ClOp(1,2), ClOp(2,3)), ClOp(2,3)

julia> a=b=Xact(1.0+1.0im); b=OpOp(0.5+1.0im, 1.5-1.0im); c=OpCl(a,b)
OpCl(Xact(1.0 + 1.0im), OpOp(0.5 + 1.0im, 1.5 - 1.0im))

julia> d=typeof(c)(cos(angle(c.lo.lo)), cos(angle(c.hi.hi)))
OpCl(0.7071067811865476, 0.8320502943378437)
```

... a deeper type ...   
Each boundary can be a directed 3D locus, giving an interval under torsion.

```julia

# most prompts omitted

using BoundIntervals
using Quaternions

q1=Quaternion(4,3,2,1);q1n=q1/norm(q1);
q2=Quaternion(1,1,3,1);q2n=q2/norm(q2);
q3=Quaternion(1,2,2,1);q3n=q3/norm(q3);
qq=OpOp(q1,q2) * OpOp(q2,q3);
qqlo=qq.lo/norm(qq.lo); qqhi=qq.hi/norm(qq.hi);

# the two boundary values, their 3D orientation and twist
julia>qqLineSeg = ClCl(norm(qq.lo), norm(qq.hi))
ClCl(10.954451150103322, 18.973665961010276)

# their 3D orientation and twist
julia> axis(qq.lo), angle(qq.lo)
([0.5345224838248489,0.8017837257372734,-0.26726124191242445],2.389552564397458)
julia> axis(qqhi),angle(qqhi)
([0.33333333333333337,0.6666666666666667,0.6666666666666667],1.892546881191539)

# this check verifies that the math lets us carry the 'normal' boundary values
#    (the values bounding qqLineSeg) with the 3D axes and angles properly
julia> isapprox(axis(qq.lo),axis(q2n*q3n)), isapprox(angle(qq.hi),angle(q1n*q2n))
(true, true)

```



