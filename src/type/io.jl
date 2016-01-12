function show{B<:AkoBound}(io::IO, x::Ivl{B})
    if x.lo != x.hi
       s = string(string(B),"(",x.lo,", ",x.hi,")")
    else
       s = string(string(B),"(",x.lo,")")
    end
    
    print(io, s)
end
