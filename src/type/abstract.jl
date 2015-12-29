# abstract types used in concrete.jl

abstract XtdRealInterval <: Real              # interval over the Extended Reals (allows +/- infinity)
abstract RealInterval    <: XtdRealInterval   # interval over the Reals 


abstract AkoBound
                        #    lo     hi
abstract CC  <: AkoBound # closed-closed
abstract CO  <: AkoBound # closed-opened
abstract OC  <: AkoBound # opened-closed
abstract OO  <: AkoBound # opened-opened
abstract XT  <: CC       # closed-closed where lo==hi, 'exact'

string(::Type{CC}) = "ClCl"
string(::Type{CO}) = "ClOp"
string(::Type{OC}) = "OpCl"
string(::Type{OO}) = "OpOp"
string(::Type{XT}) = "Xact"
