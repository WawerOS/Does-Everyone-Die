%% S_approx
clear;

N = 4;
S_num = 100;
S_df = linspace(280,140,S_num);
S0= 280;
gamma = .6;
beta = .003;

% Expanding e^x as an Nth order taylor polynomial
for ix = 1:N + 1
    exp_expand(N-ix + 2) = 1/factorial(ix - 1);
end
exp_expand(N-1) = exp_expand(N-1) - gamma;

root = roots(exp_expand);

remove = @(x,i) [x(1:i-1),x(i+1:end)];
lin_eq = zeros(N,N);

% Building the system of linear equation
for ix = 1:N
    for iy = 1:N
        inputs = remove(root',iy);
        lin_eq(ix,iy) = (-1)^(N-ix-1)*elsympol(inputs',ix-1);
    end
end

sol_for = zeros(N,1); 
sol_for(1) = 1;
coeff = lin_eq\sol_for;
t = zeros(1,S_num);
for in = 1:N
    t = t + coeff(in).*log((S_df - root(in))/(S0 - root(in)));
end
t = 2.8*t;