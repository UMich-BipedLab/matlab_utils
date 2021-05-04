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
% v1 = [0,0];
% v2 = [3,0];
% pts = [-10,5; 
%        0,10; 
%        0,15]';
% v1 = [-0.23329, 0.6961];
% v2 = [0.7019, 0.81399];
% pts = [-0.34963,-0.10683]';
%  coefficient = polyfit([v1(1) v2(1)],[v1(2), v2(2)],1); 
% distance_2D = t_pointToLineManhattanDistanceGivenLine(pts, coefficient)
function dist = pointToLineManhattanDistanceGivenLine(pts, coefficient)
    % coefficient = a, b, c, where ax + by + c = 0
    
    % if using polyfit:
    % y = p(1)x + p(2) -> p(1)x - y + p(2)
    % p = polyfit([v1(1) v2(1)],[v1(2), v2(2)],1); 
    % a = p(1), b = -1, c = p(2)
    if length(pts) > 2
        pts = makeWideMatrix(pts);
    end
    
    % http://artis.imag.fr/~Xavier.Decoret/resources/maths/manhattan/html/
    % return a sum of Manhattan distance
    dist = sum( abs(coefficient(1) * pts(1, :) + coefficient(2) * pts(2, :) + coefficient(3)) ./ max( abs(coefficient(1)), abs(coefficient(2)) ) );
end