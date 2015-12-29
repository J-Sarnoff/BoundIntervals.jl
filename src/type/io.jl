function show{B<:AkoBound}(io::IO, x::Ivl{B})
    if B!=XA
       s = string(string(B),"(",x.lo,", ",x.hi,")")
    else
       s = string(string(B),"(",x.lo,")")
    end
    
    print(io, s)
end
