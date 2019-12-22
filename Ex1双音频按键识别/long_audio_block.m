

function long_audio_block(file)
    fprintf("analysing long file %s\n", file)
    [long_data, Fs_long] = audioread([file]);
    long_data_length = length(long_data);
    interval = 1000;
    i = 1;
    fft_t = 0;
    my_g_t = 0;
    auto_g_t = 0;
    fft_res = [];
    my_g_res = [];
    auto_g_res = [];
%     fft_threshold = 1; 此处阈值设为1时，会导致识别出错，见实验报告
    fft_threshold = 2.5;
    auto_g_threshold = 1;
    my_g_threshold = 1;
    fft_switch = 0;
    auto_g_switch = 0;
    my_g_switch = 0;
    
    while i < long_data_length - interval
        [my_g_time, my_g_number, my_g_amp1, my_g_amp2] = mycode_goertzel_analyse(long_data(i:i + interval), Fs_long);
        if exist('goertzel')
            [auto_g_time, auto_g_number, auto_g_amp1, auto_g_amp2] = auto_goertzel_analyse(long_data(i:i + interval), Fs_long);
        end 
        [fft_time, fft_number, fft_amp1, fft_amp2] = fft_analyse(long_data(i:i + interval), Fs_long);
%         amp1
%         amp2
        
        if fft_amp1 > fft_threshold && fft_amp2 > fft_threshold
            if fft_switch == 0
                fft_res = [fft_res, string(fft_number)];
                fft_switch = 1;
            end
        else
            fft_switch = 0;
        end
        
        if my_g_amp1 > my_g_threshold && my_g_amp2 > my_g_threshold
            if my_g_switch == 0
                my_g_res = [my_g_res, string(my_g_number)];
                my_g_switch = 1;
            end
        else
            my_g_switch = 0;
        end
        
        if exist('goertzel')
            if auto_g_amp1 > auto_g_threshold && auto_g_amp2 > auto_g_threshold
                if auto_g_switch == 0
                    auto_g_res = [auto_g_res, string(auto_g_number)];
                    auto_g_switch = 1;
                end
            else
                auto_g_switch = 0;
            end
        end
        fft_t = fft_t + fft_time;
        my_g_t = my_g_t + my_g_time;
        auto_g_t = auto_g_t + auto_g_time;
        i = i + interval;
    end
    fft_res
    my_g_res
    if exist('goertzel')
        auto_g_res
    end
    fft_t
    my_g_t
    if exist('goertzel')
        auto_g_t
    end
end
