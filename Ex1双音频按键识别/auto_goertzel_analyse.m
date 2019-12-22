
% 调用MatLab的Signal Processing ToolBox当中的goertzel函数进行计算，该函数具体用法参考官方文档 https://ww2.mathworks.cn/help/signal/ref/goertzel.html
function [time, number, amp1, amp2] = auto_goertzel_analyse(data, Fs)
    N = length(data);
    Ts = 1 / Fs;
%     row = [697, 770, 852, 941];
%     column = [1209, 1336, 1477];
    matrix = [['1', '2', '3'], 
          ['4', '5', '6'], 
          ['7', '8', '9'], 
          ['*', '0', '#']];
    f = [697 770 852 941 1209 1336 1477];
    freq_indices = round(f/Fs*N) + 1;  % 选取目标频率值对应的点的位置
    tic;
    dft_data = goertzel(data,freq_indices);
    time = toc;  % 记录用时
    dft_data = abs(dft_data);
    [amp1, loc1] = max(dft_data(1:4));
    [amp2, loc2] = max(dft_data(5:7));
    number = matrix(loc1, loc2);  % 记录识别的数字结果
    
%     stem(f,dft_data)
%     xlabel('Frequency (Hz)')
%     title('GOERTZEL-DFT Magnitude, by auto goertzel')
end
