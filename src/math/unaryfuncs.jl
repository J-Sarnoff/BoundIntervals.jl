for (fn) in (:exp, :expm1, :log, :log1p,
             :sin, :cos, :tan, :csc, :sec, :cot,
             :asin, :acos, :atan, :acsc, :asec, :acot,
             :sinh, :cosh, :tanh, :csch, :sech, :coth,
             :asinh, :acosh, :atanh, :acsch, :asech, :acoth,
             :erf, :erfinv)
    @eval begin
       ($fn){T<:AkoBound}(x::Ivl{T}) = Ivl{T}(minmax(($fn)(x.lo),($fn)(x.hi))...) 
    end
end
