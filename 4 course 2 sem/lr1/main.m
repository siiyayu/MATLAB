err_v = [];
fs_v = [];
k = 2.5;
% for k = 1.5:0.1:3
for p = 1:1:6


    %% ������� ������� ������������� �������� �������
    % -- ������ - ����� 4-� �������� � ���������� ������������
    % ---- �������� ���������� ������������ � ��������� �������� A0 = -0.1; (������ ���� ��������!)
    A0 = 0.25;
    A1 = 1;
    A2 = 1;
    A3 = 1;
    A4 = 1;
    % ---- ������� ��������
    f1 = 500;
    f2 = 1100;
    f3 = 1700;
    f4 = 2200;
    fm = f4;
    % ---- ������� ������� �������
    s = @(t) A0 + A1*cos(2*pi*f1*t) +...
                  A2*cos(2*pi*f2*t) +...
                  A3*cos(2*pi*f3*t) +...
                  A4*cos(2*pi*f4*t);
    s_cut = @(t) A0 + A1*cos(2*pi*f1*t) +...
                  A2*cos(2*pi*f2*t);
    %-----------------------------------------------------------------
    % �������� ������ ������������ �������� � ����� ����� �������������
    % - �������� ����������������
    T0 = 1e-6;  % ��� ����� ��������� ���������, ����������������� �������
    Dt = 1e-2;  % ������������ ������� (������ ���� ��������!)
    t = 0:T0:Dt-T0; % ��������� �������� �������, ��������������� ��������
    % --- ���������� ������ ��������� ��������� ������������,
    %     ����� �����, ����� ����������, �������� ��������� �������
    %     ��� ���������� ����������� �������
    s0 = s(t);  % ������� �������
    s0_cut = s_cut(t);
    s0__ = s(t+0.00045);  % ������� �������

    %% ���������� �����������
%     [b,a] = butter(6, 2*fm*T0);
%     s0_f = filter(b,a,s0__);
    %% ������������� �������������
    fs =k*f4;
    Dn = round(1/fs/T0);
    T = Dn*T0;
    t1 = 0:T:Dt;
    n = 1:Dn:length(s0);
    tt = abs(t1(length(t1)) - Dt);
    if tt > 0 && tt < T/2
    t1 = 0:T:Dt-T;
    n = 1:Dn:length(s0)- Dn;
    % ������� ������������� (������ ���� ��������!)
    % ��� ������������ �������� �������
    % ������ �������������
    % ��������� �������� ������� ������������������� �������
    % ������� �������� ������������������� �������
    end
    s1 = s0(n); % ������������� ������������� - �������� ������� � ����� Dn
    s1_f = s0__(n);
    %% ������ ������������ ������� ��������� � ������������������� ��������
    % ������������ ����������� ������ ��������� �������
    F0 = abs(fft(s0_cut)/length(s0_cut));
    % ������������ ����������� ������ ������������������� �������
    FF1 = abs(fft(s1_f)/length(s1_f));
    df = 1/Dt;              % ��� ����� ������������� ���������
    f = 0:df:8000;          % ��������� ������ ��� ����������� ������� (������ ���� ��������!)
    F1 = zeros(1,length(f));
    for i=1:length(f)
        j = mod(i,length(s1_f));
        if j == 0
            j = length(s1_f);
        end
        F1(i) = FF1(j);
    end

    %% ���������� ������������� ������������������� �������
    % -- � ������� ��������� ����� ������ ���� ������������
%     s2 = f_Kotelnikov_sum(t, T, s1_f);
    % -- � ������� ��������� �������� �������
%     s2 = f_fix0_extrapolation(t, T, s1);
    % % -- � ������� ��������� ������� �������
    s2 = f_fix1_extrapolation(t, T, s1_f);
    [b,a] = butter(p, 2*f2*T0);
    s2 = filter(b,a,s2);

    %% ������ �������������� ��������� �������
    ds = s0_cut - s2;
    err_max = max(abs(ds));
    err_std = std(ds);
    err_v = [err_v; [err_max, err_std]];
    fs_v = [fs_v p];
%     
%  

%     subplot(3,1,1);
%     plot(t, s0);
%     hold on;  
%     grid on
%     plot(t, s2);
%     subplot(3,1,2);










% plot_fucking_shit(t, s1_f, s0, s0_f, t1,      F0, F1, f,    s2, s0_cut);
% %     %% ���������� �������� ��������� � ������������������� ��������
%     % ������ ��������� �������
%     figure
%     subplot(3,1,1);
%     plot(t, s0);
%     grid on
% %     % ����������� ������������������� �������
%     hold on;
%     
%     plot(t, s2);
%     
%     hold on;
%     
%     stem(t1(1:min(length(t1),length(s1_f))), s1_f,'r');
%     legend('s0', 'filtered', 'filtered discrete')
%     
%     % ������ ������ ������������������� �������
%     subplot(3,1,2);
%     stem(f, F1, 'diamondr');
% %     ����������� �� ���� ������ ��������� �������
%     hold on
%     stem(f, F0(1:length(f)),'b');
%     grid on
%     subplot(3,1,3);
%     plot(t, ds);
%     grid on;
%     
    %% ����������� ������� ���������������� ������� � ��� ������� ����� ���� ��������� ��� ������ ���������� ����
%     ����������� ������������������ ������ �� ��������
% 
    
% 
%     figure('Position', [50 50 800 500])
%     subplot(3,1,1);
%     hold on;
%     plot(t, s0_cut, 'r'); 
%     plot(t, s2, 'b'); 
%     grid on;
%     %----------------------------------------------------------------- 
%     % ��������� ������ ������������������� ������� � ������ ���
%     F2 = abs(fft(s2)/length(s2)); 
%     subplot(3,1,2);
%     hold on;
%     stem(f, F2(1:length(f)),'r', '*');
%     stem(f, F0(1:length(f)),'b');
%     grid on;
%     subplot(3,1,3);
%     plot(t, ds);
%     grid on;
% % 

end
plot(fs_v, err_v);
grid on;
legend('max error', 'std error');