function phasePlot(fg, x0, ax)
    %% function phasePlot(fg, x0, ax)
    % fg
    %    The differential equations whose right-hand-side's represented as
    %    functions, in CELL ARRAYS.
    % x0
    %    The initial value for SIR or SIRS models with the like of [S;I].
    % ax
    %    An axes object to hold all the graphical outputs.
    %    Defaults to result of gca.
    %
    % Note: fimplicit functionality has not been added to matlab until
    % R2016b, so recommended matlab version is at least R2016b. The
    % function will still run without errors but cannot graph nullclines at
    % all. 
    %
    % SEE ALSO: ODE45, AXES, GCA, CELL, FIMPLICIT
    
    %% Default argument
    if nargin < 3; ax = gca; end
    
    %% Version Filter for fimplicit
    % fimplicit is introduced in R2016b, namely MatLab 9.1
    if verLessThan('matlab', '9.1')
        fimplicit = @(~,~,~,~)0;
    end
    
    %% Data and constant
    
    xif = {
        0, 200;
        0, 200;
    };
    
    n = 40; 
    
    % System of DiffEq
    tInt = [
        -100
        100
    ]';
    
    func = @(t,x)[
        fg{1}(x(1),x(2))
        fg{2}(x(1),x(2))
    ];
    
    
    [~, X] = ode45(func, tInt, x0);
    
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
    scale = .7;
    quiver(ax,Xn{:}, uv{:}, scale, 'r')
    hold(ax,'on')
        p1 = plot(ax,X(:, 1), X(:, 2), 'k');
        %legend()
    hold(ax,'off')
    
    hold(ax,'on')
        p2 = fimplicit(ax,fg{1}, 'b', axisRange);
        %legend()
    hold(ax,'off')
    
    hold(ax,'on')
        p3 = fimplicit(ax,fg{2}, 'g', axisRange);

    hold(ax,'off')
   
    legend([p1,p2,p3],'ode solution','S-Nullcline','I-Nullclines')
    axis(ax,axisRange)
    xlabel(ax,'S'), ylabel(ax,'I')
    
    
    
    
    
    
    
    
    
    
    
    
    
    
