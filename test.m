% Initialize
mdl_puma560
q = rand(1,6);
qd = rand(1,6);
delta = 1e-6;

n = p560.n;
M = p560.inertia(q);

% Compute alpha(i,j,k) = dM(i,j)/dq(k)
alpha = zeros(n, n, n);
for k = 1:n
    q_perturbed = q;
    q_perturbed(k) = q_perturbed(k) + delta;
    M_perturbed = p560.inertia(q_perturbed);
    dM_dqk = (M_perturbed - M) / delta;
    alpha(:, :, k) = dM_dqk;
end

% Assume you've already computed alpha(i,j,k)
% Now compute beta(i,j,k)
beta = zeros(n, n, n);

for i = 1:n
    for j = 1:n
        for k = 1:n
            beta(i,j,k) = 0.5 * ( ...
                alpha(i,j,k) + ...
                alpha(i,k,j) - ...
                alpha(j,k,i))
        end
    end
end

