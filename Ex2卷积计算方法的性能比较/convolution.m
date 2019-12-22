% 调用各卷积算法的入口函数
function convolution(x1_start, x1_end, x1_interval, x2_start, x2_end, x2_interval)
    legend_cell = [];  % 图例记录
    for x1_length = x1_start : x1_interval : x1_end
        sample_num = floor((x2_end - x2_start) / x2_interval); % 共有多少组输出，方便在下面提前分配内存并且初始化
        standard_time = zeros([1, sample_num]); % 预分配内存
        circle_time = zeros([1, sample_num]); % 预分配内存
        overlap_add_time = zeros([1, sample_num]); % 预分配内存
        overlap_save_time = zeros([1, sample_num]); % 预分配内存
        cnt = 1;
        length(standard_time)
        length(circle_time)
        x1 = rand([1, x1_length]);  % 随机生成1*x1_length的矩阵，即x1为长度为x1_length的向量
        fprintf("calculating x1_length = %d\n", x1_length);
        for x2_length = x2_start : x2_interval : x2_end
            x2 = rand([1, x2_length]);  % 随机生成1*x2_length的矩阵，即x2为长度为x2_length的向量
            [standard_time(cnt), ~] = standard_conv(x1, x2, x1_length, x2_length);
            [circle_time(cnt), ~] = circle_conv(x1, x2, x1_length, x2_length);
            [overlap_add_time(cnt), ~] = overlap_add_conv(x1, x2, x1_length, x2_length);
            [overlap_save_time(cnt), ~] = overlap_save_conv(x1, x2, x1_length, x2_length);

            % 输出进度，注释输出语句可以运行更快
            fprintf("calculating x1_length = %d, x2_length = %d\n", x1_length, x2_length);
            fprintf("standard convolution: %d s,circle convolution: %d s, overlap-add convolution: %d s, overlap-save convolution: %d s\n ", standard_time(cnt), circle_time(cnt), overlap_add_time(cnt), overlap_save_time(cnt));
            
            cnt = cnt + 1;
        end
        x2_axis = x2_start : x2_interval : x2_end;
        plot(x2_axis, standard_time, x2_axis, circle_time, x2_axis, overlap_add_time, x2_axis, overlap_save_time)
        legend_cell = [legend_cell, string(strcat('standard conv, x1 length=', num2str(x1_length))), string(strcat('circle conv, x1 length=', num2str(x1_length))), string(strcat('overlap-add, x1 length=', num2str(x1_length))), string(strcat('overlap-save, x1 length=', num2str(x1_length)))]; %#ok<AGROW>
        hold on
    end

    % 设置图例、坐标轴标题
    legend(legend_cell)
    xlabel('x2 length')
    ylabel('time cost/s')
end
