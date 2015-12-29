function sqrt{B<:akoBound}(a::Ivl{B})
    lo = sqrt(a.lo)
    hi = sqrt(a.hi)
    Ivl{B}(lo, hi)
end
