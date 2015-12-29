# applicative conversion

ClCl( x::Ivl{Xact} ) = Ivl{ClCl}(x.lo,x.hi)
ClCl( x::Ivl{ClCl} ) = x
ClCl( x::Ivl{ClOp} ) = Ivl{ClCl}(x.lo,x.hi)
ClCl( x::Ivl{OpCl} ) = Ivl{ClCl}(x.lo,x.hi)
ClCl( x::Ivl{OpOp} ) = Ivl{ClCl}(x.lo,x.hi)


OpOp( x::Ivl{Xact} ) = Ivl{OpOp}(prevfloat(x.lo),nextfloat(x.hi))
OpOp( x::Ivl{ClCl} ) = Ivl{OpOp}(prevfloat(x.lo),nextfloat(x.hi))
OpOp( x::Ivl{ClOp} ) = Ivl{OpOp}(prevfloat(x.lo),x.hi)
OpOp( x::Ivl{OpCl} ) = Ivl{OpOp}(x.lo,nextfloat(x.hi))
OpOp( x::Ivl{OpOp} ) = x

