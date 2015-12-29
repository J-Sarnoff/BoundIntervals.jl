function show{B<:AkoBound}(io::IO, x::Ivl{B})
    s = string(B,"(",x.lo,", ",x.hi,")")
    print(io, s)
end
