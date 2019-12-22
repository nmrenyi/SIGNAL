

% 我实现的goertzel算法识别，实现方法参考老师课上PPT
function [time, number, amp1, amp2] = mycode_goertzel_analyse(data, Fs)
    N=length(data);
    matrix = [['1', '2', '3'], 
          ['4', '5', '6'], 
          ['7', '8', '9'], 
          ['*', '0', '#']];
    f_origin = [697 770 852 941 1209 1336 1477];
    x = data;
    dft_data = zeros([1, length(f_origin)]); % 预分配内存
    cnt = 1;
    f = f_origin * N / Fs;  % 目标频率对应的点的位置
    tic;
    for k = f
        v = zeros([1, N]);  % v(0) == v(-1) == 0, 下标从1开始
%         y = zeros([1, N]);
        v(1) = x(1);
        v(2) = x(2) + 2 * cos(2 * pi * k / N) * v(1);
        for n = 3 : N
            v(n) = x(n) + 2 * cos(2 * pi * k / N) * v(n - 1) - v(n - 2); % 参考老师PPT上的实现方法进行计算
        end
        % 计算yk_(N),即为X(k)的值
        rotate_factor = exp(-1i * 2 * pi / N * k);
        dft_data(cnt) = v(n) - v(n - 1) * rotate_factor;
        cnt = cnt + 1;
    end
    time = toc; % 记录时间
    dft_data = abs(dft_data);
    % 选取两个频率目标区间内的最大值
    [amp1, loc1] = max(dft_data(1:4));
    [amp2, loc2] = max(dft_data(5:7));
    
    number = matrix(loc1, loc2); % 记录识别的数字
    
    % 调试用的画图函数
%     stem(f_origin,dft_data)
%     xlabel('Frequency (Hz)')
%     title('GOERTZEL-DFT Magnitude, by my code goertzel')
end