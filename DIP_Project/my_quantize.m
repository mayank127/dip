function quant = my_quantize(I,L)
    Imax=max(I(:));
    Imin=min(I(:));
    range=Imax-Imin;
    scale=(L-1)/range;
    quant=round(I*scale)/scale;
end