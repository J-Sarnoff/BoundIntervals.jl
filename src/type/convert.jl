
convert(::Type{Ivl{CO}}, x::Ivl{CC}) = ClOp(x)
convert(::Type{Ivl{OC}}, x::Ivl{CC}) = OpCl(x)
convert(::Type{Ivl{OO}}, x::Ivl{CC}) = OpOp(x)
convert(::Type{Ivl{CC}}, x::Ivl{CO}) = ClCl(x)
convert(::Type{Ivl{OC}}, x::Ivl{CO}) = OpCl(x)
convert(::Type{Ivl{OO}}, x::Ivl{CO}) = OpOp(x)
convert(::Type{Ivl{CC}}, x::Ivl{OC}) = ClCl(x)
convert(::Type{Ivl{CO}}, x::Ivl{OC}) = ClOp(x)
convert(::Type{Ivl{OO}}, x::Ivl{OC}) = OpOp(x)
convert(::Type{Ivl{CC}}, x::Ivl{OO}) = ClCl(x)
convert(::Type{Ivl{OC}}, x::Ivl{OO}) = OpCl(x)
convert(::Type{Ivl{CO}}, x::Ivl{OO}) = ClOp(x)
convert(::Type{Ivl{CC}}, x::Ivl{XA}) = ClCl(x.lo,x.lo)
convert(::Type{Ivl{OC}}, x::Ivl{XA}) = OpCl(x.lo,x.lo)
convert(::Type{Ivl{CO}}, x::Ivl{XA}) = ClOp(x.lo,x.lo)
convert(::Type{Ivl{OO}}, x::Ivl{XA}) = OpOp(x.lo,x.lo)

promote_rule(::Type{Ivl{CC}},::Type{Ivl{CO}}) = Ivl{CO}
promote_rule(::Type{Ivl{CC}},::Type{Ivl{OC}}) = Ivl{OC}
promote_rule(::Type{Ivl{CC}},::Type{Ivl{OO}}) = Ivl{OO}
promote_rule(::Type{Ivl{CO}},::Type{Ivl{OC}}) = Ivl{OO}
promote_rule(::Type{Ivl{CO}},::Type{Ivl{OO}}) = Ivl{OO}
promote_rule(::Type{Ivl{OC}},::Type{Ivl{OO}}) = Ivl{OO}
promote_rule(::Type{Ivl{CC}},::Type{Ivl{XA}}) = Ivl{CC}
promote_rule(::Type{Ivl{CO}},::Type{Ivl{XA}}) = Ivl{CO}
promote_rule(::Type{Ivl{OC}},::Type{Ivl{XA}}) = Ivl{OC}
promote_rule(::Type{Ivl{OO}},::Type{Ivl{XA}}) = Ivl{OO}

convert{F<:AbstractFloat}(::Type{Ivl{CC}}, x::F) = ClCl(x,x)
convert{F<:AbstractFloat}(::Type{Ivl{CO}}, x::F) = ClOp(x,nextfloat(x))
convert{F<:AbstractFloat}(::Type{Ivl{OC}}, x::F) = OpCl(prevfloat(x),x)
convert{F<:AbstractFloat}(::Type{Ivl{OO}}, x::F) = OpOp(prevfloat(x),nextfloat(x))
convert{F<:AbstractFloat}(::Type{Ivl{XA}}, x::F) = Xact(x)

convert{F<:Integer}(::Type{Ivl{CC}}, x::F) = ClCl(x,x)
convert{F<:Integer}(::Type{Ivl{CO}}, x::F) = ClOp(x,x)
convert{F<:Integer}(::Type{Ivl{OC}}, x::F) = OpCl(x,x)
convert{F<:Integer}(::Type{Ivl{OO}}, x::F) = OpOp(x,x)
convert{F<:Integer}(::Type{Ivl{XA}}, x::F) = Xact(x)

promote_rule{F<:AbstractFloat}(::Type{Ivl{CC}}, ::Type{F}) = Ivl{CC}
promote_rule{F<:AbstractFloat}(::Type{Ivl{CO}}, ::Type{F}) = Ivl{CO}
promote_rule{F<:AbstractFloat}(::Type{Ivl{OC}}, ::Type{F}) = Ivl{OC}
promote_rule{F<:AbstractFloat}(::Type{Ivl{OO}}, ::Type{F}) = Ivl{OO}
promote_rule{F<:AbstractFloat}(::Type{Ivl{XA}}, ::Type{F}) = Ivl{XA}

promote_rule{F<:Integer}(::Type{Ivl{CC}}, ::Type{F}) = Ivl{CC}
promote_rule{F<:Integer}(::Type{Ivl{CO}}, ::Type{F}) = Ivl{CO}
promote_rule{F<:Integer}(::Type{Ivl{OC}}, ::Type{F}) = Ivl{OC}
promote_rule{F<:Integer}(::Type{Ivl{OO}}, ::Type{F}) = Ivl{OO}
promote_rule{F<:Integer}(::Type{Ivl{XA}}, ::Type{F}) = Ivl{XA}
