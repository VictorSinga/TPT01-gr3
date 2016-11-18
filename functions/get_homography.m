% finds a homography defined by four corresponding points
% input: two sets of corresponding points (column vectors, 4 points per set)
% outpu: homography defined by the corresponding points
function H = get_homography(u1, u2)
    A = zeros(8, 9);    
    for i = 1:4
        A(2*i-1,:) = [-u1(1,i), -u1(2,i), -1, 0, 0, 0, u1(1,i)*u2(1,i), u1(2,i)*u2(1,i), u2(1,i)];
        A(2*i,:) = [0, 0, 0, -u1(1,i), -u1(2,i), -1, u1(1,i)*u2(2,i), u1(2,i)*u2(2,i), u2(2,i)];
    end
    H = null(A);
    H = reshape(H, [3, 3])';
end