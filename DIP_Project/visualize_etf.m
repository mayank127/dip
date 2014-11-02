function Mlist = visualize_etf(Tx, Ty)
    v(:,:,1) = Tx;
    v(:,:,2) = Ty;
    [n, m] = size(Tx);
    M = randn(n);
    % parameters for the LIC
    options.histogram = 'linear'; % keep contrast fixed
    options.verb = 0;
    options.dt = 1.5; % time steping
    % size of the features
    options.flow_correction = 1;
    options.niter_lic = 2; % several iterations gives better results
    % iterated lic
    Mlist = zeros(n,m);
    for i=1:4
        options.M0 = M;
        Mlist = perform_lic(v, i, options);
    end
    % display
    imageplot(Mlist);