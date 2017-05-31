%% phase_plot

tic;
clc;clear;

beta = .003;
gamma = .6;
nu = .2;
N = 400;

x1i = 0;
x1f = gamma/beta+20;
x2i = 0;
x2f = gamma/beta+20;
n = 40;

percent_sick = .3;
% System of DE
%f = @(x1,x2) -beta.*x1.*x2 - nu*x1 - nu*x2 +nu*N;
%g = @(x1,x2) (beta.*x1 - gamma).*x2;

f = @(x1,x2) -beta.*x1.*x2;
g = @(x1,x2) (beta.*x1 - gamma).*x2;
%tInt = [0,1.8];
tInt = [-100,100];
x0 = [N*(1-percent_sick),N*percent_sick];
func = @(t,x) [f(x(1),x(2)); ...
               g(x(1),x(2))];
[T,X] = ode45(func,tInt,x0);

%% Arrays
x1 = linspace(x1i,x1f,n);
x2 = linspace(x2i,x2f,n);
[X1,X2] = meshgrid(x1,x2);

%% Calc
dx1 = f(X1,X2);
dx2 = g(X1,X2);
u = dx1./sqrt(dx1.^2 + dx2.^2);
v = dx2./sqrt(dx1.^2 + dx2.^2);

%% Display
quiver(X1,X2,u,v,1,'r')
hold on
    plot(X(:,1),X(:,2),'k');
hold off
hold on
    fimplicit(f,'b',[x1i x1f x2i x2f])
hold off
hold on
    fimplicit(g,'g',[x1i x1f x2i x2f])
hold off
axis([x1i x1f x2i x2f]);
xlabel('x1')
ylabel('x2')