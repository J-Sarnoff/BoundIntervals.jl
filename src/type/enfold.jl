# applicative conversions that maintain enclosure

Xact( x::Ivl{XA} ) = x
Xact( x::Ivl{CC} ) = Ivl{XA}(x.lo/2+x.hi/2)
Xaxt( x::Ivl{CO} ) = Ivl{XA}(x.lo/2+x.hi/2)
Xact( x::Ivl{OC} ) = Ivl{XA}(x.lo/2+x.hi/2)
Xact( x::Ivl{OO} ) = Ivl{XA}(x.lo/2+x.hi/2)

ClCl( x::Ivl{XA} ) = Ivl{CC}(x.lo,x.hi)
ClCl( x::Ivl{CC} ) = x
ClCl( x::Ivl{CO} ) = Ivl{CC}(x.lo,x.hi)
ClCl( x::Ivl{OC} ) = Ivl{CC}(x.lo,x.hi)
ClCl( x::Ivl{OO} ) = Ivl{CC}(x.lo,x.hi)

ClOp( x::Ivl{XA} ) = Ivl{CO}(x.lo,nextfloat(x.hi))
ClOp( x::Ivl{CC} ) = Ivl{CO}(x.lo,nextfloat(x.hi))
ClOp( x::Ivl{CO} ) = x
ClOp( x::Ivl{OC} ) = Ivl{CO}(x.lo,nextfloat(x.hi))
ClOp( x::Ivl{OO} ) = Ivl{CO}(x.lo,x.hi)

OpCl( x::Ivl{XA} ) = Ivl{OC}(prevfloat(x.lo),x.hi)
OpCl( x::Ivl{CC} ) = Ivl{OC}(prevfloat(x.lo),x.hi)
OpCl( x::Ivl{CO} ) = Ivl{OC}(prevfloat(x.lo),x.hi)
OpCl( x::Ivl{OC} ) = x
OpCl( x::Ivl{OO} ) = Ivl{OC}(x.lo,nextfloat(x.hi))

OpOp( x::Ivl{XA} ) = Ivl{OO}(prevfloat(x.lo),nextfloat(x.hi))
OpOp( x::Ivl{CC} ) = Ivl{OO}(prevfloat(x.lo),nextfloat(x.hi))
OpOp( x::Ivl{CO} ) = Ivl{OO}(prevfloat(x.lo),x.hi)
OpOp( x::Ivl{OC} ) = Ivl{OO}(x.lo,nextfloat(x.hi))
OpOp( x::Ivl{OO} ) = x

