function phasePlot(func)
    %% function phasePlot
    tic
    
    %% Data and constant
    beta = 3e-3;
    gamma = .6;
    nu = .2;
    N= 4e2;
    
    xif = {
        0, 200;
        0, 200;
    };
    
    n = 40; 
    
    
    % System of DiffEq
    
    fg = {
        @(x,y)-beta.*x.*y
        @(x,y)y.*(beta.*x-gamma)
    };
    
    tInt = [
        0
        1.8
    ]';
    
    sickPerc = .3;
    x0 = N * ([1 0] - sickPerc * [1 -1]);
    
    %{
    func = @(t,x)[
        fg{1}(x(1),x(2))
        fg{2}(x(1),x(2))
    ];
    %}
    
    [T, X] = ode45(func, tInt, x0);
    
    xn = cell(1, 2);
    parfor ind = 1 : numel(xn)
        xn{ind} = linspace(xif{ind, :}, n);
    end
    
    [X1, X2] = meshgrid(xn{:});
    
    Xn = {X1, X2};
    
    %% Calculations
    
    dxn = cell(1, 2);
    parfor ind = 1 : numel(dxn)
        dxn{ind} = fg{ind}(Xn{:});
    end
    
    uv = cell(1, 2);
    
    pow_ = .5;
    
    denum = (dxn{1} .^ 2 + dxn{2} .^ 2) .^ pow_;
    
    parfor ind = 1 : numel(uv)
        uv{ind} = dxn{ind} ./ denum;
    end
    
    %% Output result
    axisRange = [xif{1, :}, xif{2, :}];
    scale = .4;
    quiver(Xn{:}, uv{:}, scale, 'r')
    hold on
    plot(X(:, 1), X(:, 2), 'k')
    % fimplicit(fg{1}, 'b', axisRange)
    % fimplicit(fg{2}, 'g', axisRange)
    hold off
    axis(axisRange)
    xlabel x1, ylabel y1
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
