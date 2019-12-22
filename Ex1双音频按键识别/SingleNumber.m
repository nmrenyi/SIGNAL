% 测试函数，对folder文件夹下录制好的DTMF音频文件进行识别
function SingleNumber(folder)
    files = [];  % 文件列表，在输出的时候需要
    fft_res = [];  % fft算法得到的数字识别结果
    fft_t = [];  % fft算法所用时间
    my_goertzel_res = [];  % 调用我写的goertzel函数进行处理的识别结果
    my_goertzel_time = [];  % 调用我写的goertzel函数进行处理的运行时间
    if exist('goertzel')  % 如果有Signal Processing ToolBox当中的goertzel函数
        auto_goertzel_number = [];  % 调用MatLab自带的goertzel函数进行处理的识别结果
        auto_goertzel_time = [];  % 调用MatLab自带的goertzel函数进行处理的运行时间
    end

    % 获取folder文件夹下所有文件(folder文件夹下需只有音频文件)
    fileFolder=fullfile('./',folder);
    dirOutput=dir(fullfile(fileFolder,'*.*'));
    fileNames={dirOutput.name};
    fileNames = fileNames(3: length(fileNames));  % 前两个元素为'.'和'..'，后面的元素为目录下的文件名
    % 对每个文件进行识别
    for file = fileNames
        fprintf("analysing %s\n", file{1})
        files = [files, string(file{1})];
        
        [data, Fs] = audioread(['./',folder,'/',file{1}]);  % 读入文件
        dims = (size(data));
        if dims(2) == 2
            data = (data(:, 1) + data(:, 2)) ./ 2;
        end
        [fft_time, fft_number] = fft_analyse(data, Fs);  % fft处理
        [my_goertzel_t, my_goertzel_number] = mycode_goertzel_analyse(data, Fs);  % 我实现的goertzel函数处理
        if exist('goertzel')
            [goertzel_time, goertzel_number] = auto_goertzel_analyse(data, Fs);  % MatLab自带的goertzel函数处理
        end

        % 记录所花费的时间和得到的结果
        fft_t = [fft_t, fft_time]; 
        fft_res = [fft_res, string(fft_number)];
        my_goertzel_res = [my_goertzel_res, string(my_goertzel_number)];
        my_goertzel_time = [my_goertzel_time, my_goertzel_t];
        if exist('goertzel')
            auto_goertzel_time = [auto_goertzel_time, goertzel_time];
            auto_goertzel_number = [auto_goertzel_number, string(goertzel_number)];
        end
    end

    fprintf("all files name : ")
    files
    
    % 输出结果
    fft_res 
    my_goertzel_res 
    if exist('goertzel')
        auto_goertzel_number 
    end
    % 输出时间
    fft_t 
    my_goertzel_time
    if exist('goertzel')
        auto_goertzel_time 
    end
    x = 1 : 1 : length(files);
%     plot(x, fft_t)
    plot(x, fft_t, x, my_goertzel_time, x, auto_goertzel_time)
    legend('fft', 'my goertzel', 'auto goertzel');
    cell = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'star', 'hash'};
    set(gca,'xtick',x);
    set(gca,'xticklabel',cell);
    xlabel('character')
    ylabel('time cost/s')
    title(strcat(folder, ' dtmf time cost test'))
end