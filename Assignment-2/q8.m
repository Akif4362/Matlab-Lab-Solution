clc; clear;
num = input('input number as string (eg. "020106561") : ');
num = char(num);
if length(num) == 12
    sum = 0;
    for i = 1:length(num)
        if mod(i,2) == 0
            sum = sum + 3 * str2double(num(i));
        else
            sum = sum + str2double(num(i));
        end
        
    end
    
    digit13 = mod(-sum, 10);
    fprintf("13th digit is %d", digit13)

elseif length(num) == 9 
    sum = 0;
    for i = 1:length(num)
        sum = sum + i*str2double(num(i));
    end
    
    [~, inv, ~] = gcd(10,11);
    digit10 = mod(inv*(-sum), 11);
    fprintf("10th digit is %d", digit10)

else
    disp("input 9 or 12 digits (as string with quotation)")
end


    

