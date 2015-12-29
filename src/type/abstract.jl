# abstract types used in concrete.jl

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
