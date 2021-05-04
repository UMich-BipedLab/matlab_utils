function pasuseANDSaveFigure(opts, fig_h, save_name, prompt_txt)
    if ~exist('prompt_txt', 'var')
        prompt_txt = "Save it for not? \n 0: [no] \n 1: [yes] \n";
    end
    commandwindow;
    save_again = 1;
    while save_again
        x = input(prompt_txt);
        if x
            saveCurrentPlot(fig_h, save_name)
            fprintf("Saved: %s\n", save_name)
        else
            disp("Skipping...")
        end
        save_again = input("Save it again? \n 0: [no] \n 1: [yes] \n");
    end
end