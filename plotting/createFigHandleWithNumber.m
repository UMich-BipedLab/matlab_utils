%{
 * Copyright (C) 2013-2020, The Regents of The University of Michigan.
 * All rights reserved.
 * This software was developed in the Biped Lab (https://www.biped.solutions/) 
 * under the direction of Jessy Grizzle, grizzle@umich.edu. This software may 
 * be available under alternative licensing terms; contact the address above.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * The views and conclusions contained in the software and documentation are those
 * of the authors and should not be interpreted as representing official policies,
 * either expressed or implied, of the Regents of The University of Michigan.
 * 
 * AUTHOR: Bruce JK Huang (bjhuang[at]umich.edu)
 * WEBSITE: https://www.brucerobot.com/
%}

% testing code
% clc, clear
% close all
% clear_fig = 0;
% show_fig = 0;
% handle = t_createFigHandleWithNumber(2, 100, "test", clear_fig, show_fig);
% plot(handle(1),[1 2 3],[2 4 6]);
% plot(handle(2),[10 20 30],[20 40 60]);
% set(get(handle(1),'parent'),'visible','on');% show the current axes
% set(get(handle(2),'parent'),'visible','on');% show the current axes


function [axes_handles, fig_handles] = createFigHandleWithNumber(...
    num_handles, start_number, name, clear_fig, show_fig, font_size)
%     fig_handle = zeros(1,num_handles);
%     fig_handle = cell(1, num_handles);
    start_number = max(1, start_number);
    axes_handles = [];
    fig_handles = [];
    if ~exist('clear_fig', 'var') || isempty(clear_fig)
        clear_fig = 1;
    end
    if ~exist('show_fig', 'var') || isempty(show_fig)
        show_fig = 0;
    end
    if ~exist('font_size', 'var') || isempty(font_size)
        font_size = 30;
    end
    for i = start_number : start_number+num_handles-1
%         set(0,'DefaultFigureVisible','off');
        if ishandle(i)
            if clear_fig
%                 clf(i,'reset');
                clf(i);
            end
            if show_fig
                set(i, 'Name', name + "-" + num2str(i-start_number+1), ...
                    'Visible', 'on');
            else
                set(i, 'Name', name + "-" + num2str(i-start_number+1), ...
                    'Visible', 'off');
            end
            axes_h = gca(i);
            axes_h.FontSize = font_size;
            hold(axes_h, 'on');
            axes_handles = [axes_handles; axes_h];
            fig_handles = [fig_handles; findall(i,'type','figure')];
        else
            fig = figure(i);
            if show_fig
                set(fig, ...
                    'Name', name + "-" + num2str(i-start_number+1), ...
                    'Visible', 'on');
            else
                set(fig, ...
                    'Name', name + "-" + num2str(i-start_number+1), ...
                    'Visible', 'off');
            end
            
            axes_h = axes('parent', i);
            hold(axes_h, 'on');
            axes_h.FontSize = font_size;
            axes_handles = [axes_handles; axes_h];
            fig_handles = [fig_handles; fig];
        end
%         hold(gca(fig), "on")
    end
end
