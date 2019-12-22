% overlap-save方法，参考资料https://www.comm.utoronto.ca/~dkundur/course_info/real-time-DSP/notes/8_Kundur_Overlap_Save_Add.pdf
function [time, result] = overlap_save_conv(x1, x2 ,x1_length, x2_length)
    tic;
    % 选择出长度较短的那个向量
    if x1_length > x2_length
        long = x1;
        short = x2;
    else
        long = x2;
        short = x1;
    end
    N = length(long); % 较长的向量的长度
    M = length(short); % 较短的向量的长度
    L = floor(M * log2(N));  % 设定每一块的大小，此处每块长度的选取与qi
    long = [long, zeros([1, ceil(N / L) * L - N])]; % 在结尾补零，使其长度成为L的倍数
    N = length(long); % 记录序列的长度
    result = zeros([1, N + M - 1]); % 结果的长度
    long = [zeros([1, M - 1]), long];  % 在序列前面补上M - 1个0，为overlap-save做准备
    short_fft = fft(short, L + M - 1);  % 做L+M-1点FFT,存储备用
    i = 1; % 在原序列上的计数器
    while i < N
        tmp = ifft(fft(long(i:i + L + M - 2), L + M - 1).*short_fft, L + M - 1);
        result(i:i + L - 1) = result(i:i + L -1) + tmp(M : L + M - 1);  % 舍弃掉开头的M - 1个点，将计算出的结果不重叠地加到对应位置
        i = i + L;  % 前进到下一块
    end
    % 保存用时
    time = toc;
end

