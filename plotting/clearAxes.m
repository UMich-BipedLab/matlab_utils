function clearAxes(axes_handles)
    for i = 1:length(axes_handles)
       cla(axes_handles(i));
    end
end