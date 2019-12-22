% 使用圆卷积进行卷积
function [time, result] = circle_conv(x1, x2 ,x1_length, x2_length)
    tic;
    % 将两个向量通过结尾补零的方式，都变成x1_length + x2_length - 1的长度
    % fft指定点数后，自动在长度不足的序列后补零
    % 满足圆卷积等于线卷积的条件, L >= L_x1 + L_x2 - 1
    L = x1_length + x2_length - 1;
    result = ifft(fft(x1, L).*fft(x2, L));  % 注意使用.*,即逐元素乘法,matlab默认乘法为矩阵相乘
    % 保存用时
    time = toc;
end
