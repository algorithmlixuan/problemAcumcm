function [ initial_A] = read()

    [initial_A]=xlsread('DATA.xlsx',2,'A3:B5403');
end

