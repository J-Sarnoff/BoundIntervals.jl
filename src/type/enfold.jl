# applicative conversion

ClCl( x::Ivl{Xact} ) = Ivl{ClCl}(x.lo,x.hi)
ClCl( x::Ivl{ClCl} ) = x
ClCl( x::Ivl{ClOp} ) = Ivl{ClCl}(x.lo,x.hi)
ClCl( x::Ivl{OpCl} ) = Ivl{ClCl}(x.lo,x.hi)
ClCl( x::Ivl{OpOp} ) = Ivl{ClCl}(x.lo,x.hi)

