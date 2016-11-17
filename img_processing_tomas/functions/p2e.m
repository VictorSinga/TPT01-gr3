function u_e = p2e(u_p)
    if(size(u_p, 1) == 3)
        u_e = [u_p(1,:) ./ u_p(3,:); u_p(2,:) ./ u_p(3,:)];
    else
        u_e = [u_p(1,:) ./ u_p(4,:); u_p(2,:) ./ u_p(4,:); u_p(3,:) ./ u_p(4,:)];
    end
end

