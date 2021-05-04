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

function h = plotMultiplePolygonsVertices(image_handle, polygons_vertices, color_list, hold_on)

    num_objs = length(polygons_vertices);
    if ~exist('color_list', 'var')
        color_list = '';
    end
    
    if ~exist('hold_on', 'var')
        hold_on = 'on';
    end
    hold(image_handle, hold_on)
    
    if length(color_list) ~= num_objs
        for i = 1 : length(polygons_vertices)
            if isfield(polygons_vertices, 'object_vertices')
                h = plotConnectedVerticesStructure(image_handle, polygons_vertices(i).object_vertices);
            else
                h = plotConnectedVerticesStructure(image_handle, polygons_vertices(i).vertices);
            end
        end
    else
        for i = 1 : num_objs
%             color_list(i)
            if isfield(polygons_vertices, 'object_vertices')
                plotConnectedVerticesStructure(image_handle, polygons_vertices(i).object_vertices, color_list{i})
            else
                h = plotConnectedVerticesStructure(image_handle, polygons_vertices(i).vertices, color_list{i});
            end
        end        
    end
    if ~nargout % if nargout == 0
       clearvars % or simply clearvars y
    end
end