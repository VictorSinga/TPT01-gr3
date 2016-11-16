
function [ isEmpty ] = emptyRowInBorders( row,from,to, noizeRate)
%UNTITLED8 Returns if the row consists only of zeroes
isEmpty = true;
s = 0;
for i = from : to
    if row(i)~=0
        s =s+1;
    end;
end;

if(s/(to-from)>noizeRate)
    isEmpty = false;
end;

end
