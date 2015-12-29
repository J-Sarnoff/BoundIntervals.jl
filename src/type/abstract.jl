# abstract types used in concrete.jl

abstract AkoBound
                        #    lo     hi
abstract CC  <: AkoBound # closed-closed
abstract CO  <: AkoBound # closed-opened
abstract OC  <: AkoBound # opened-closed
abstract OO  <: AkoBound # opened-opened
abstract EX  <: CC       # closed-closed where lo==hi, 'exact'

