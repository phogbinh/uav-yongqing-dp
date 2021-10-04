function result = dp(E_FULL, clusters, dist)
%% intialization
    CLUSTER_1_STATIONS_N = numel( clusters(1).stations );
    for station_i = 1:CLUSTER_1_STATIONS_N
        if clusters(1).stations(station_i).isCharged
            clusters(1).stations(station_i).remDist = E_FULL;
        end % else current station remDist = 0
    end
    
%% execute
    CLUSTERS_N = numel(clusters);
    for cluster_i = 2:CLUSTERS_N
        DES_STATIONS_N = numel( clusters(cluster_i).stations );
        for des_station_i = 1:DES_STATIONS_N
            minCost = Inf;
            minCostRemDist = -1;
            SRC_STATIONS_N = numel( clusters(cluster_i - 1).stations );
            for src_station_i = 1:SRC_STATIONS_N
                reach = clusters(cluster_i - 1).stations(src_station_i).remDist ...
                      - dist(cluster_i - 1, src_station_i, cluster_i, des_station_i);
                if reach >= 0
                    cost = clusters(cluster_i - 1).stations(src_station_i).cost ...
                         + dist(cluster_i - 1, src_station_i, cluster_i, des_station_i);
                    if cost < minCost
                        minCost = cost;
                        minCostRemDist = reach;
                        if clusters(cluster_i).stations(des_station_i).isCharged
                            minCostRemDist = E_FULL;
                        end
                    end
                end
            end
            clusters(cluster_i).stations(des_station_i).cost = minCost;
            clusters(cluster_i).stations(des_station_i).remDist = minCostRemDist;
        end
    end

%% return
    result = clusters;
end