% 公式法进行卷积
function [time, result] = standard_conv(x1, x2 ,x1_length, x2_length)
    tic;
    result_length = x1_length + x2_length -1;  % 卷积后结果为卷积前两向量长度和减1
    result = zeros([1, result_length]); % 预分配内存并初始化
    % 公式法进行卷积
    for n = 1 : result_length
        start = max(1, n + 1 - x1_length);
        ending = min(x2_length, n);
        for k = start : ending
            result(n) = result(n) + x1(n + 1 - k) * x2(k); % 按照公式进行计算
        end
    end
    % 保存用时
    time=toc;
end
