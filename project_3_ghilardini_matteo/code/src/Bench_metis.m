function [cut_recursive,cut_kway] = Bench_metis(picture)
% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.
%
% D.P & O.S for Numerical Computing at USI

KEEP_16=false;
KEEP_32=true;


    %  Add necessary paths
    addpaths_GP;
    whos;
    
    % Graphs in question
    % HELICOPTER
    h_sparse_matrix = load('helicopter.mat');
    h_params = Initialize_case(h_sparse_matrix); 
    h_W = h_params.Adj;       
    h_coords = h_params.coords;
    fprintf('Helicopter size: %d\n', size(h_W,1));

    % SKIRT
    s_sparse_matrix = load('skirt.mat');
    s_params = Initialize_case(s_sparse_matrix); 
    s_W = s_params.Adj;       
    s_coords = s_params.coords;
    fprintf('Skirt size: %d\n', size(s_W,1));
    
    % Steps
    % 1. Initialize the cases
    cut_recursive = zeros(2, 2); % Rows: [16, 32 partitions]; Columns: [helicopter, skirt]
    cut_kway = zeros(2, 2); % Rows: [16, 32 partitions]; Columns: [helicopter, skirt]
    
    % 2. Call metismex to
    %     a) Recursively partition the graphs in 16 and 32 subsets.
    [h_recursive_map_16, cut_recursive(1, 1)] = metismex('PartGraphRecursive', h_W, 16);
    [h_recursive_map_32, cut_recursive(2, 1)] = metismex('PartGraphRecursive', h_W, 32);
    [s_recursive_map_16, cut_recursive(1, 2)] = metismex('PartGraphRecursive', s_W, 16);
    [s_recursive_map_32, cut_recursive(2, 2)] = metismex('PartGraphRecursive', s_W, 32);
    
    %     b) Perform direct k-way partitioning of the graphs in 16 and 32 subsets.
    [h_kway_map_16, cut_kway(1, 1)] = metismex('PartGraphKway', h_W, 16);
    [h_kway_map_32, cut_kway(2, 1)] = metismex('PartGraphKway', h_W, 32);
    [s_kway_map_16, cut_kway(1, 2)] = metismex('PartGraphKway', s_W, 16);
    [s_kway_map_32, cut_kway(2, 2)] = metismex('PartGraphKway', s_W, 32);
    
    % 3. Visualize the results for 32 partitions
    fprintf('Partitions \tHelicopter Recursive \tHelicopter K-way \tSkirt Recursive \tSkirt K-way\n');
    fprintf(repmat('-', 1, 100)); % Line separator
    fprintf('\n');
    
    % Print the cut values for 16 and 32 partitions
    % Print the cut values for 16 and 32 partitions with tabs
    fprintf('16\t\t%d\t\t\t%d\t\t\t%d\t\t\t%d\n', ...
        cut_recursive(1, 1), cut_kway(1, 1), cut_recursive(1, 2), cut_kway(1, 2));
    fprintf('32\t\t%d\t\t\t%d\t\t\t%d\t\t\t%d\n', ...
        cut_recursive(2, 1), cut_kway(2, 1), cut_recursive(2, 2), cut_kway(2, 2));
    
    % HELICOPTER
    figure;
    gplotg(h_W, h_coords);
    rotate3d on;
    title('Helicopter - Original Graph');

    % Helicopter Recursive
    if(KEEP_16)
        figure;
        gplotmap(h_W, h_coords, h_recursive_map_16);
        rotate3d on;
        title('Helicopter - Recursive Bisection (16 partitions)');
    end;

    if(KEEP_32)
        figure;
        gplotmap(h_W, h_coords, h_recursive_map_32);
        rotate3d on;
        title('Helicopter - Recursive Bisection (32 partitions)');
    end;

    % Helicopter K-Way
    if(KEEP_16)
        figure;
        gplotmap(h_W, h_coords, h_kway_map_16);
        rotate3d on;
        title('Helicopter - K-Way Bisection (16 partitions)');
    end;

    if(KEEP_32)
        figure;
        gplotmap(h_W, h_coords, h_kway_map_32);
        rotate3d on;
        title('Helicopter - K-Way Bisection (32 partitions)');
    end;

    % SKIRT
    figure;
    gplotg(s_W, s_coords);
    rotate3d on;
    title('Skirt - Original Graph');

    % Skirt Recursive
    if(KEEP_16)
        figure;
        gplotmap(s_W, s_coords, s_recursive_map_16);
        rotate3d on;
        title('Skirt - Recursive Bisection (16 partitions)');
    end;

    if(KEEP_32)
        figure;
        gplotmap(s_W, s_coords, s_recursive_map_32);
        rotate3d on;
        title('Skirt - Recursive Bisection (32 partitions)');
    end;

    % Skirt K-Way
    if(KEEP_16)
        figure;
        gplotmap(s_W, s_coords, s_kway_map_16);
        rotate3d on;
        title('Skirt - K-Way Bisection (16 partitions)');
    end;

    if(KEEP_32)
        figure;
        gplotmap(s_W, s_coords, s_kway_map_32);
        rotate3d on;
        title('Skirt - K-Way Bisection (32 partitions)');
    end;
end
