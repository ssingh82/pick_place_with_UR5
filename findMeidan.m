function index=findMeidan(vec)
% The input should be a column vector
% Ye Tian, Dec. 2016
sortVec=sort(vec);
vecLength=length(vec);
val=sortVec(ceil(vecLength/2));
index=find(vec==val);
end