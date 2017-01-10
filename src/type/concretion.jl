
#=
   isless is needed in ordering lo,hi
   these definitions with IvlNum typealiased to Any
   expand the scope of available bounding value types
=#
Base.isless{N1<:Number,N2<:Number}(a::N1,b::N2) = Base.isless(norm(a),norm(b))
Base.isless{A1<:Array,A2<:Array}(a::A1,b::A2) = isless(norm(a),norm(b))
Base.isless{N<:Number}(a::N,b::Array{N}) = isless(norm(a),norm(b)) 
Base.isless{N<:Number}(a::Array{  N,    b::A) = isless(norm(a),norm(b))

typealias IvlNum Any

# allow lo, hi to differ in type (subtypes of Real)
# R <-- promote_type(typeof(lo),typeof(hi))

immutable Ivl{B<:AkoBound}  <: Real
    lo::IvlNum
    hi::IvlNum
end

# if values are given hi,lo the bounds will be swapped
for (op,T) in [(:ClCl,:CC), (:ClOp,:CO), (:OpCl,:OC), (:OpOp, :OO)]
  @eval begin
    function ($op)(lo::IvlNum, hi::IvlNum)
        low,hig= promote(lo,hi)
        if (low > hig)
           Ivl{swapBound[$T]}(hi,lo)
        else
           Ivl{$T}(lo,hi)
        end
    end
    function ($op){R<:IvlNum}(lo::R, hi::R)
        if lo > hi
           Ivl{swapBound[$T]}(hi,lo)
        else
           Ivl{$T}(lo,hi)
        end   
    end    
    ($op)(x::Real) = Ivl{$T}(x,x)
  end
end  
Xact(x::IvlNum) = Ivl{XA}(x,x)

# for use in programming, lowercased they sort lo,hi but do not swap bounds
for (op,T) in [(:clcl,:CC), (:clop,:CO), (:opcl,:OC), (:opop, :OO)]
  @eval begin
    function ($op)(lo::IvlNum, hi::IvlNum)
        low,hig= promote(lo,hi)
        if (low > hig)
           Ivl{$T}(hi,lo)
        else
           Ivl{$T}(lo,hi)
        end
    end
    function ($op){R<:IvlNum}(lo::R, hi::R)
        if lo > hi
           Ivl{$T}(hi,lo)
        else
           Ivl{$T}(lo,hi)
        end   
    end    
    ($op)(x::Real) = Ivl{$T}(x,x)
  end
end  
xact(x::Real) = Ivl{XA}(x,x)


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

