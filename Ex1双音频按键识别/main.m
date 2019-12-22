% 本文件中通过FFT, matlab的Signal Processing ToolBox中自带的goertzel函数和我自己实现的goertzel函数这3种方法，对比了其识别DTMF音频文件时的用时和准确度
% 注意，MatLab中自带的goertzel函数只在Signal Processing包中有。若未安装此工具包，则不能运行这个函数

% 测试接口
% [data, Fs] = audioread(['./data/dtmf-1.wav']);
% [my_g_time, my_g_number] = mycode_goertzel_analyse(data, Fs)
% [auto_g_time, auto_g_number] = auto_goertzel_analyse(data, Fs);
% [fft_time, fft_number] = fft_analyse(data, Fs)

testSingleNumber()
% testLongFile()
% [data, Fs] = audioread(['./long_audio/18800111626.m4a']);
% Ts = 1/Fs;
% l = length(data);
% x = (1:l)*Ts;
% plot(x, data)
% xlabel('time/s')
% ylabel('amplitude')
% title('./long\_audio/18800111626.m4a的时域图像')


% 识别单个按键音音频的函数接口
function testSingleNumber()
    % 可通过切换注释的方式调用不同数据
    folder = 'standard-dtmf1';
    % folder = 'standard-dtmf2';
%     folder = 'huawei';
%     folder = 'oppo';
    SingleNumber(folder)
end

% 识别多个按键音音频的函数接口
function testLongFile()
    % 可通过切换注释的方式调用不同数据
%     long_file = './long_audio/18800111626.m4a';
%     long_file = './long_audio/13791191098.wav';
%     long_file = './long_audio/18750763198.wav';
%     long_file = './long_audio/sequential.m4a';
%     long_audio_block(long_file)
    long_audio_threshold(long_file)
end
