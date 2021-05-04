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

function [x, y, modelInliers, inlierPts] = ransacLineWithVerticality(points, threshold, fraction, verticality_threshold)
    % plot3(cur_axes, x, y, [min(inlierPts(:,1)) max(inlierPts(:,1))], 'r')
    if ~exist('verticality_threshold', 'var')
        verticality_threshold = 1.2;
    end
    n = size(points, 1);
    std_dev = std(points(1:2, :), 1, 2);
    verticality = std_dev(2)/std_dev(1);
    
    if verticality > verticality_threshold
        points = points([2 1 linspace(3, n , n - 3 + 1)], :);
        [y, x, modelInliers, inlierPts] = ransacLineWithInlier(points', threshold, fraction);
        modelInliers = [1/modelInliers(1), -modelInliers(2)/modelInliers(1)];
        if size(inlierPts, 2) == 2
            inlierPts = inlierPts(:, [2 1]);
        elseif size(inlierPts, 2) == 3
            inlierPts = inlierPts(:, [2 1 3]);
        elseif size(inlierPts, 2) == 5
            inlierPts = inlierPts(:, [2 1 3 4 5]);
        end
        
    else
        [x, y, modelInliers, inlierPts] = ransacLineWithInlier(points', threshold, fraction);
    end
end