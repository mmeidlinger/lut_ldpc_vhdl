function [ g ] = getGirth(H)
% This function return the Girth of the graph of the LDPC code that is
% defined by the parity check matrix H. The complexity is lower than O( (N+M)^4  )
% REFERNECES:
% http://stackoverflow.com/questions/12890106/find-the-girth-of-a-graph
% http://www.geeksforgeeks.org/greedy-algorithms-set-6-dijkstras-shortest-path-algorithm/




M = size(H,1);
N = size(H,2);


g = inf;

A = [zeros(N,N) , H.' ;
       H        , zeros(M,M)];

for mm=1:M
    for nn=1:N
        is_connected = A(nn,N+mm);
        if is_connected
            % if there is a connection between variable node nn and checknode
            % mm, remove the conntection
            A(nn,N+mm)=0;
            A(N+mm,nn)=0;
            
            % find the shortest path between VN nn and CN mm
            d = dijkstra(A, nn, N+mm);
            if(d+1 < g)
                g = d+1;
            end

            % reestablish the conntection between variable node nn and checknode mm
            A(nn,N+mm)=is_connected;
            A(N+mm,nn)=is_connected;
        end
    end
end


end


function min_index =  minDistance(d_vec, sptSet)
    % Initialize min value
    min_index =inf;
    min_val = inf;
    V = length(d_vec);
    
    for vv = 1:V
        if (sptSet(vv) == false && d_vec(vv) <= min_val)
            min_val = d_vec(vv);
            min_index = vv;
        end
    end
end


function d_min = dijkstra(A, source, target)
    d_min = inf;
    V = size(A,1);
    dist = inf(1,V);     %  The output array.  dist(i) will hold the shortest distance from src to i
    
    sptSet = false(1,V); % sptSet(i) will true if vertex i is included in shortest path tree or shortest distance from src to i is finalized
    

    dist(source) = 0;  % Distance of source vertex from itself is always 0
    
    % Find shortest path for all vertices
    for vv1=1:V
        % Pick the minimum distance vertex from the set of vertices not
        % yet processed. u is always equal to src in first iteration.
        uu = minDistance(dist, sptSet);
        if (uu == target)
            d_min = dist(uu);
            return
        end
        
        % Mark the picked vertex as processed
        sptSet(uu) = true;
        
        % Update dist value of the adjacent vertices of the picked vertex.
        for vv2=1:V
            
            % Update dist[v] only if is not in sptSet, there is an edge from
            % u to vv2, and total weight of path from src to  vv2 through u is
            % smaller than current value of dist[vv2]
            if (~sptSet(vv2) && A(uu,vv2) && dist(uu) < inf  && dist(uu)+A(uu,vv2) < dist(vv2))
                dist(vv2) = dist(uu) + A(uu,vv2);
            end
    

        end
    end
end
