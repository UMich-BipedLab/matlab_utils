function ordered_list = listConsecutiveOrder(start_num, end_num)
    num_numbers = end_num-start_num+1;
    ordered_list = zeros(2, num_numbers);
    
    for i=1:num_numbers
        i;
        j = max(mod(i+1, num_numbers+1), 1);
        ordered_list(:, i) = [i; j];
    end
end