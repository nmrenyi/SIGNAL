% 本文件中对向量x1, x2进行了公式法、圆卷积法、overlap-add和overlap-save方法的卷积，并且对各方法用时进行比较
% Copyright 任一 2018011423

% 设置x1, x2的初始参数
% x1, x2的长度值都是可以调整的，根据设定的输入长度随机生成序列进行x1与x2卷积的测试
% start代表初始迭代的长度，序列长度从start开始，每次加interval，直到超过end停止
x1_start = int32(1000);
x1_end = int32(5000);
x1_interval = int32(2000);
x2_start = int32(100);
x2_end = int32(30000);
x2_interval = int32(100);

% 调用入口函数，对设置好参数的序列进行卷积
convolution(x1_start, x1_end, x1_interval, x2_start, x2_end, x2_interval)
