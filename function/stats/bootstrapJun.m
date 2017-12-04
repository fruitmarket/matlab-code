function [p,m_ori_pv] = bootstrapJun(vector1, vector2, nShuffle)
[size_row, size_col] = size(vector1);

m_shf_pv = zeros(nShuffle,1);
[ori_pv, pv] = deal(zeros(1,124));

%% original correlation value
for iCol = 1:size_col
    ori_pv(iCol) = corr(vector1(:,iCol),vector2(:,iCol),'type','Pearson');
end
m_ori_pv = nanmean(ori_pv);

%% shuffled correlation value
for iShuffle = 1:nShuffle
    newVector = [vector1; vector2];
    shuffle_B = newVector;
    
    [shuffle_A, idx_A] = datasample(newVector,size_row,'Replace',false);
    shuffle_B(idx_A,:) = [];
    
    for iCol = 1:size_col
        pv(iCol) = corr(shuffle_A(:,iCol),shuffle_B(:,iCol),'type','Pearson');
    end
    m_shf_pv(iShuffle) = nanmean(pv);
end
p = sum(double(m_shf_pv > m_ori_pv))/nShuffle;
end