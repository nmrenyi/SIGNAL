

% fft算法的数字识别,fft参考了官方文档 https://ww2.mathworks.cn/help/matlab/ref/fft.html?requestedDomain=cn
function [fft_time, result, amp1, amp2]=fft_analyse(data, Fs)
    % 频率表和对应的数字表，待查
    row = [697, 770, 852, 941];
    column = [1209, 1336, 1477];
    matrix = [['1', '2', '3'], 
          ['4', '5', '6'], 
          ['7', '8', '9'], 
          ['*', '0', '#']];
    Ts = 1 / Fs; % 采样频率
    L = length(data); % 音频点数
    t = (0 : L - 1) * Ts;  % 时间长度
    tic;
    Y = fft(data);
    fft_time = toc;  % 记录处理时间
    P2 = abs(Y); % P2为双边谱
    P1 = P2(1:floor(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);  % P1为单边谱，幅度进行了叠加，方便分析
    f = Fs*(0:(L/2))/L;  % f为频率横坐标, 将Fs/2，分了L/2份
    [f1, f2, amp1, amp2] = getFreq(f, P1);  % 获取两个幅度最大的频率值，f1在600-1000Hz,f2在1100-1550Hz 
    [~,index1] = min(abs(row - f1));  % 获取与row中频率相差最小的频率位置
    [~,index2] = min(abs(column - f2));  % 获取与column中频率相差最小的频率位置
    result = matrix(index1, index2);
    % 调试时所用的画图函数
%     plot(f, P1)
%     title('FFT-Single-Sided Amplitude Spectrum of X(t)')
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')
end

% 计算频率轴为f，幅度轴为P1(单边谱)
% 在600-1000(对应横行频率的值697 770 852 941), 1100-1550(对应纵列的频率值1209 1336 1477)的两个最大频率值
function [f1, f2, amp1, amp2] = getFreq(f, P1)
    % 思路是选取距离600和1000最近的两个点作为待查找序列的起点和终点，在起点和终点之间内，查找幅度最大的频率值
    [~, start1]=min(abs(f-600));
    [~, end1] = min(abs(f-1000));
    [amp1 ,max_loc1] = max(P1(start1:end1));
    f1 = f(max_loc1 + start1 - 1);
    [~, start2] = min(abs(f-1100));
    [~, end2] = min(abs(f-1550));
    [amp2 , max_loc2] = max(P1(start2:end2));
    f2 = f(max_loc2 + start2 - 1);
end
