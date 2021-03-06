% ��������� ������
M  = 11; % - ����������� ������� ���������
dT = 0.1; % - �������� ������� ����� �����������
V  = 5; % - ���������� �������� ������� ����������
D0 = 10; % - ��������� ��������� �� ������� ����������
sigma1 = 1; % - ��� ���������� ������ ���������
sigma2 = 20; % - ��� ���������� ������ ���������
p = 0.00; % - ��������� ����������� ��������� ���������� ������
T  = (dT*0:(M-1))'; % ������ �������� ������� ���������
D  = D0 + V*T; % ������ �������� ����������
A = zeros(M, 2); % ������� ������ ����������
for i=1:M
    A(i,:) = [1, T(i)];
end
K = 11; % - ����� ����� ��������� ����������� �����������
dp = 0.01; % - ��� ��������� ����������� �����������
N = 10000; % - ����� ������������� ��� ����� ����������
eQ = zeros(2,K);
sQ = zeros(2,K);
for k=1:K
    %
    p = (k-1)*dp;
    for j=1:N
        % ��������� ����������
        S = zeros(M,1);
        for i=1:M
            if rand < p
                sigma = sigma2;
            else
                sigma = sigma1;
            end
            S(i) = D(i) + sigma*randn;
            end
    % ������� ������ ��������� ��������� � ��������
        Q = inv(A'*A)*A'*S;
       % Q = f_iter_M(S, A, sigma1, 6, [8; 6], 1e-3, @f_w_BisquareTukey);
        eQ(:,k) = eQ(:,k) + Q; % �������
        sQ(:,k) = sQ(:,k) + Q.^2; % ���������
    end
    eQ(:,k) = eQ(:,k)/N;
    sQ(:,k) = sQ(:,k)/N - eQ(:,k).^2;
    fprintf('%2d: p = %g, mean = [%g, %g], stddev = [%g, %g]\n',...
    k, p, eQ(1,k), eQ(2,k), sqrt(sQ(1,k)), sqrt(sQ(2,k)));
end
pp=(0:K-1)*dp;
figure
subplot(2,2,1);
plot(pp, eQ(1,:)-D0);
grid on;
subplot(2,2,2);
plot(pp, eQ(2,:)-V);
grid on
subplot(2,2,3)
plot(pp, sqrt(sQ(1,:)));
grid on
subplot(2,2,4)
plot(pp, sqrt(sQ(2,:)));
grid on
