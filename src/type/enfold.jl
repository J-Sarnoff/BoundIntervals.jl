# applicative conversion

Xact( x::Ivl{Xact} ) = x
Xact( x::Ivl{ClCl} ) = Ivl{XA}(x.lo/2+x.hi/2)
Xaxt( x::Ivl{ClOp} ) = Ivl{XA}(x.lo/2+x.hi/2)
Xact( x::Ivl{OpCl} ) = Ivl{XA}(x.lo/2+x.hi/2)
Xact( x::Ivl{OpOp} ) = Ivl{XA}(x.lo/2+x.hi/2)

ClCl( x::Ivl{Xact} ) = Ivl{CC}(x.lo,x.hi)
ClCl( x::Ivl{ClCl} ) = x
ClCl( x::Ivl{ClOp} ) = Ivl{CC}(x.lo,x.hi)
ClCl( x::Ivl{OpCl} ) = Ivl{CC}(x.lo,x.hi)
ClCl( x::Ivl{OpOp} ) = Ivl{CC}(x.lo,x.hi)

ClOp( x::Ivl{Xact} ) = Ivl{CO}(x.lo,nextfloat(x.hi))
ClOp( x::Ivl{ClCl} ) = Ivl{CO}(x.lo,nextfloat(x.hi))
ClOp( x::Ivl{ClOp} ) = x
ClOp( x::Ivl{OpCl} ) = Ivl{CO}(x.lo,nextfloat(x.hi))
ClOp( x::Ivl{OpOp} ) = Ivl{CO}(x.lo,x.hi)

OpCl( x::Ivl{Xact} ) = Ivl{OC}(prevfloat(x.lo),x.hi)
OpCl( x::Ivl{ClCl} ) = Ivl{OC}(prevfloat(x.lo),x.hi)
OpCl( x::Ivl{ClOp} ) = Ivl{OC}(prevfloat(x.lo),x.hi)
OpCl( x::Ivl{OpCl} ) = x
OpCl( x::Ivl{OpOp} ) = Ivl{OC}(x.lo,nextfloat(x.hi))

OpOp( x::Ivl{Xact} ) = Ivl{OO}(prevfloat(x.lo),nextfloat(x.hi))
OpOp( x::Ivl{ClCl} ) = Ivl{OO}(prevfloat(x.lo),nextfloat(x.hi))
OpOp( x::Ivl{ClOp} ) = Ivl{OO}(prevfloat(x.lo),x.hi)
OpOp( x::Ivl{OpCl} ) = Ivl{OO}(x.lo,nextfloat(x.hi))
OpOp( x::Ivl{OpOp} ) = x

