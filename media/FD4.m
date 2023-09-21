% solve ut + ux = 0
% subject to IC u(x,0) = 0.04/[1+0.96cosx]
% on 0 <= x <= 2pi, 0 <= t <= 2pi
% Thank you to Damien for helping me out!

function foobar(type)
    assert(type == 1 || type == 2);
    if(type == 1)
        foo()
    else
        bar()
    end
    
end

% (a) using FD4
function foo
    % grid setup
    N = 100;
    x = linspace(0, 2*pi, N); 
    t = linspace(0, 2*pi, N);
    
    % matrix setup
    A = zeros(N);
    A = A + diag(repmat(2/3, [1,N-1]), 1);
    A = A + diag(repmat(-2/3, [1,N-1]), -1);
    A = A + diag(repmat(1/12, [1,N-2]), -2);
    A = A + diag(repmat(-1/12, [1,N-2]), 2);
    A(1, N-1) = 1/12;
    A(2,N) = 1/12;
    A(1,N) = -2/3;
    A(N-1,1) = -1/12;
    A(N,2) = -1/12;
    A(N,1) = 2/3;  
    A = A * N/(2*pi);
    
    % solving the PDE
    F = @(t,u) (-A*u);
    uo = 0.04./(1+0.96.*cos(x));
    [~,y] = ode45(F,t,uo);
    mesh(y)
    % plot(t,y,'o'); 
    % plot(t,y,'o-'); 

end

%(b) using fourdif
function bar
    N = 100;
    t = linspace(0, 2*pi, N);
    [x,DM] = fourdif(N,1);
    F = @(t,u) (-DM*u);
    uo = 0.04./(1+0.96.*cos(x));
    [~,y] = ode45(F,t,uo);
    mesh(y)
end


