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
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS AS IS AND
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


% vertices.x = [20 20 20 20 -20 -20 -20 -20];
% vertices.y = [10 10 -10 -10 10 10 -10 -10];
% vertices.z = [10 -10 10 -10 10 -10 10 -10];
% vertices.faces = t_createBoxFaces(vertices)

function faces = createBoxFaces(vertices)
    if isstruct(vertices)
        vertices_mat = convertXYZstructToXYZmatrix(vertices);
    else
        vertices_mat = polygon_vertices;
    end
    
    % According to LiDAR coord.
    % Front
    [~, ind_max_x] = maxk(vertices_mat(1,:), 4);
    [faces(1).normal, faces(1).centroid] = computePlane(vertices_mat(:, ind_max_x));
    
    % Back
    [~, ind_min_x] = mink(vertices_mat(1,:), 4);
    [faces(2).normal, faces(2).centroid] = computePlane(vertices_mat(:, ind_min_x));
    
    % Left
    [~, ind_max_y] = maxk(vertices_mat(2,:), 4);
    [faces(3).normal, faces(3).centroid] = computePlane(vertices_mat(:, ind_max_y));
    
    % Right
    [~, ind_min_y] = mink(vertices_mat(2,:), 4);
    [faces(4).normal, faces(4).centroid] = computePlane(vertices_mat(:, ind_min_y));

    % Top
    [~, ind_max_z] = maxk(vertices_mat(3,:), 4);
    [faces(5).normal, faces(5).centroid] = computePlane(vertices_mat(:, ind_max_z));
    
    % Bottom
    [~, ind_min_z] = mink(vertices_mat(3,:), 4);
    [faces(6).normal, faces(6).centroid] = computePlane(vertices_mat(:, ind_min_z));
end
