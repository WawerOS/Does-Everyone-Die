function phasePlot(fg,x0,ax)
    %% function phasePlot
    tic
    
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
    xlabel(ax,'x1'), ylabel(ax,'y1')
    
    
    
    
    
    
    
    
    
    
    
    
    
    
