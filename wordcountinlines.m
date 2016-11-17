function count=wordcountinlines(line)
    line1=imcomplement(line);
    [a b]=size(line1);
    se1=strel('line',ceil(a*2),90);
    se2=strel('line',ceil(b/300),0);
    fil=imclose(imdilate(line1,se1),se2);
    cc=bwconncomp(fil,4);
    count=cc.NumObjects;
end