% 使用overlap-add方法进行卷积，参考资料https://www.comm.utoronto.ca/~dkundur/course_info/real-time-DSP/notes/8_Kundur_Overlap_Save_Add.pdf
% 分段卷积时，使用了fft算法加快速度
function [time, result] = overlap_add_conv(x1, x2 ,x1_length, x2_length)
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
    L = floor(M * log2(N));  % 设定每一块的大小
    long = [long, zeros([1, ceil(N / L) * L - N])]; % 在结尾补零，使其长度成为L的倍数
    N = length(long);  % 更新
    result = zeros([1, N + M - 1]);
    short_fft = fft(short, L + M - 1);  % 做L+M-1点FFT,存储备用
    i = 1;
    while i < N
        tmp = ifft(fft(long(i:i + L - 1), L + M - 1).*short_fft, L + M - 1);  % 对L长的block做L + M - 1点的FFT，之后再与之前的到的FFT结果做IFFT
        result(i:i+L + M - 2) = result(i:i+L + M -2) + tmp; % 将计算出的结果叠加到对应位置
        i = i + L;  % 前进到下一块
    end
    % 保存用时
    time = toc;
end
