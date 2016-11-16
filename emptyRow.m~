function [ isEmpty ] = emptyRow( row, noizeRate)
%UNTITLED8 Returns if the row consists only of zeroes
isEmpty = true;
s = 0;
for i = 1 : size(row)
    if row(i)~=0
        s =s+1;
    end;
end;

if(s/size(row)>noizeRate)
    isEmpty = false;
end;

end

