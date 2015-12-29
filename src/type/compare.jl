
(==){B<:AkoBound}(a::Ivl{B}, b::Ivl{B}) = ((a.lo == b.lo) & (a.hi == b.hi))
(!=){B<:AkoBound}(a::Ivl{B}, b::Ivl{B}) = ((a.lo != b.lo) | (a.hi != b.hi))
(<=){B<:AkoBound}(a::Ivl{B}, b::Ivl{B}) = ((a.lo <= b.lo) & (a.hi <= b.hi))
(>=){B<:AkoBound}(a::Ivl{B}, b::Ivl{B}) = ((a.lo >= b.lo) & (a.hi >= b.hi))
(< ){B<:AkoBound}(a::Ivl{B}, b::Ivl{B}) = (!(a >= b))
(> ){B<:AkoBound}(a::Ivl{B}, b::Ivl{B}) = (!(a <= b))

(isequal){B<:AkoBound}(a::Ivl{B}, b::Ivl{B}) = (a == b)
(isless ){B<:AkoBound}(a::Ivl{B}, b::Ivl{B}) = (a <  b)

(==){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2}) = (B1==XA && (B2==CC & b.lo==b.hi)) | (B2==XA && (B1==CC & a.lo==a.hi))
(!=){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2}) = !(a==b)
(<=){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2}) = (<=)(OpOp(a),OpOp(b))
(>=){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2}) = (>=)(OpOp(a),OpOp(b))
(< ){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2}) = (!(a >= b))
(> ){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2}) = (!(a <= b))

(isequal){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2}) = (a == b)
(isless ){B1<:AkoBound,B2<:AkoBound}(a::Ivl{B1}, b::Ivl{B2}) = (a <  b)
