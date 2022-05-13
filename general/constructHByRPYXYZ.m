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

% testing code
% clc
% rpy = [10 20 30]; % in degree
% xyz = [10, 0, 20];
% H = t_constructHByRPYXYZ(rpy, xyz, 1) 
% default is moving points in the same frame

function H = constructHByRPYXYZ(rpy, xyz, type)
    if ~isvector(rpy) || ~isvector(xyz)
        error("inputs have to be two vectors")
    end
    if length(rpy) ~= 3 || length(xyz) ~=3
        error("wrong input sizes: \n --- length of RPY: %i \n --- length of XYZ: %i", length(rpy), length(xyz))
    end
    if ~iscolumn(xyz)
        xyz = xyz';
    end
    
    if ~exist('type', 'var')
        type = "1";
    end
    
    if contains(string(type), "1", 'IgnoreCase', true) || ...
       contains(string(type), "moving", 'IgnoreCase', true) || ...
       contains(string(type), "points", 'IgnoreCase', true)
%        disp(1)
        H = constructHByRPYXYZMovingPoints(rpy, xyz);
        
    elseif contains(string(type), "2", 'IgnoreCase', true) || ...
           contains(string(type), "changing", 'IgnoreCase', true) || ...
           contains(string(type), "coordinate", 'IgnoreCase', true) || ...
           contains(string(type), "frame", 'IgnoreCase', true)
%         disp(2)
%         H = constructHByRPYXYZChangingCoordinates(rpy, xyz);
        H = inv(constructHByRPYXYZMovingPoints(rpy, xyz));
    else
        error("Undefined option: %s; The option should be 'moving points', 'changing coordinate', 1, 2", string(type))
    end
end
