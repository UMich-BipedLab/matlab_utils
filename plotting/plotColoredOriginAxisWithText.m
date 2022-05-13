%{
 * Copyright (C) 2013-2025, The Regents of The University of Michigan.
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

function plotColoredOriginAxisWithText(axes_handle, txt, pose_H, length, width, axis_offset, text_offset, text_color)

    if ~exist('length', 'var') || isempty(length)
        length = 1;
    end
    if ~exist('pose_H', 'var') || isempty(pose_H)
        pose_H = eye(4);
    end
    if ~exist('width', 'var') || isempty(width)
        width =2;
    end
    if ~exist('axes_handle', 'var')
        axes_handle = createFigHandle(1, "");
    end
    
    if ~exist('axis_offset', 'var') || isempty(axis_offset)
        axis_offset = 0.2;
    end
    if ~exist('text_offset', 'var') || isempty(text_offset)
        text_offset = [0.1, 0, -0.1];
    end
    if ~exist('text_color', 'var') || isempty(text_color)
        text_color = 'k';
    end
    
    if isnumeric(axes_handle) && ~isempty(axes_handle)
        figure(axes_handle)
        axes_handle = get(gcf,'CurrentAxes');
    end
    
    if isempty(axes_handle)
        axes_handle = createFigHandle(1, "");
    end
    
    if ~exist('txt', 'var')
        txt = "";
    end
    
    origin = pose_H(1:3, 4);
%     pose_H(1:3, 1:3) = pose_H(1:3, 1:3)';
    x_arrow = pose_H * ([length; 0; 0; 0]);
    y_arrow = pose_H * ([0; length; 0; 0]);
    z_arrow = pose_H * ([0; 0; length; 0]);
    hold(axes_handle, 'on')
    plot3(axes_handle, [origin(1), origin(1) + x_arrow(1)], [origin(2), origin(2) + x_arrow(2)], [origin(3), origin(3) + x_arrow(3)], 'r', 'LineWidth', width)
    plot3(axes_handle, [origin(1), origin(1) + y_arrow(1)], [origin(2), origin(2) + y_arrow(2)], [origin(3), origin(3) + y_arrow(3)], 'g', 'LineWidth', width)
    plot3(axes_handle, [origin(1), origin(1)+  z_arrow(1)], [origin(2), origin(2) + z_arrow(2)], [origin(3), origin(3) + z_arrow(3)], 'b', 'LineWidth', width)


    text_x_offset = pose_H * ([axis_offset; 0; 0; 0]);
    text_y_offset = pose_H * ([0; axis_offset; 0; 0]);
    text_z_offset = pose_H * ([0; 0; axis_offset; 0]);
    text(axes_handle, origin(1) + x_arrow(1) + text_x_offset(1), ...
                      origin(2) + x_arrow(2) + text_x_offset(2), ...
                      origin(3) + x_arrow(3) + text_x_offset(3), ...
                      "$x$", 'interpreter','latex', ...
                      'FontSize', axes_handle.FontSize, 'Color', text_color);
    text(axes_handle, origin(1) + y_arrow(1) + text_y_offset(1), ...
                      origin(2) + y_arrow(2) + text_y_offset(2), ...
                      origin(3) + y_arrow(3) + text_y_offset(3), ...
                      "$y$", 'interpreter','latex', 'FontSize', axes_handle.FontSize, 'Color', text_color);
    text(axes_handle, origin(1) + z_arrow(1) + text_z_offset(1), ...
                      origin(2) + z_arrow(2) + text_z_offset(2), ...
                      origin(3) + z_arrow(3) + text_z_offset(3), ...
                      "$z$", 'interpreter','latex', 'FontSize', axes_handle.FontSize, 'Color', text_color);
                  
    text(axes_handle, origin(1) - text_offset(1), ...
                      origin(2) - text_offset(2), ...
                      origin(3) - text_offset(3), ...
                      txt, 'interpreter','latex', 'FontSize', axes_handle.FontSize, 'Color', text_color);
end