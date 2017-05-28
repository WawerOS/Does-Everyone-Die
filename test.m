phase_plot;
plot(T,X(:,1),'r-*')

S_approx;
hold on
plot(-t,S_df,'b-*')
legend ode45 'log approx'
hold off