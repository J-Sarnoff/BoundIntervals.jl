
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

