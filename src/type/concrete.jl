# bounded extended real intervals with open/closed/mixed bounds

# allow lo, hi to differ in type (subtypes of Real)
# R <-- promote_type(typeof(lo),typeof(hi))

immutable Ivl{B<:AkoBound}  <: XtdRealInterval
    lo::Real                        
    hi::Real
end

for (op,T) in [(:ClCl,:CC), (:ClOp,:CO), (:OpCl,:OC), (:OpOp, :OO)]
  @eval begin
    function ($op)(lo::Real, hi::Real)
        low,hig= promote(lo,hi)
        if (low > hig)
           Ivl{swapBound[$T]}(hi,lo)
        else
           Ivl{$T}(lo,hi)
        end
    end
    function ($op){R<:Real}(lo::R, hi::R)
        if lo > hi
           Ivl{swapBound[$T]}(hi,lo)
        else
           Ivl{$T}(hi,lo)
        end   
    end    
    ($op)(x::Real) = Ivl{$T}(x,x)
  end
end  
Xact(x::Real) = Ivl{XA}(x,x)

# discover the kind of bound
bound{B<:AkoBound}(::Type{Ivl{B}}) = B
bound{B<:AkoBound}(x::Ivl{B}) = B

# characterize the kind of bound
# false for closed bound, true for open bound 
for (T,lo,hi) in ((:CC,false,false), (:CO,false,true), (:OC,true,false), (:OO,true,true), (:XA,false,false))
    @eval bounds(::Type{Ivl{$T}}) = ($lo,$hi)
    @eval bounds(x::Ivl{$T}) = ($lo,$hi)
    @eval bounds(::Type{$T}) = ($lo,$hi)
end

# impute a kind of bound
const BoundVec = [CC, OC, CO, OO];
bound(lo::Bool, hi::Bool) = BoundVec[(one(Int8) + reinterpret(Int8, lo) + (reinterpret(Int8, hi) << 1))]



