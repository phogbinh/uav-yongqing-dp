%% parameters
E_FULL = 10;
CLUSTERS_N = 2;
CLUSTER_STATIONS_MAX_N = 1;
CLUSTER_1_STATIONS_N = 1;
CLUSTER_2_STATIONS_N = 1;

%% setup
clusters(CLUSTERS_N, 1) = cluster;
% cluster 1
tempStations(CLUSTER_1_STATIONS_N, 1) = station;
clusters(1).stations = tempStations;
clusters(1).stations(1).isCharged = false;
clear tempStations;
% cluster 2
tempStations(CLUSTER_2_STATIONS_N, 1) = station;
clusters(2).stations = tempStations;
clusters(2).stations(1).isCharged = false;
clear tempStations;
% distances
dist = zeros(CLUSTERS_N, CLUSTER_STATIONS_MAX_N, CLUSTERS_N, CLUSTER_STATIONS_MAX_N);
dist(1, 1, 2, 1) = 6; % 1.1 -> 2.1

%% execute
clusters = dp(E_FULL, clusters, dist);

%% assert
assert(clusters(1).stations(1).cost == 0);
assert(clusters(1).stations(1).remDist == 0);
assert(clusters(2).stations(1).cost == Inf);
assert(clusters(2).stations(1).remDist == -1);

%% clear
clear;