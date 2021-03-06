%% ������� ���������� ��� ���� ��������
Nbr = 4;
[b_1, a_1, N1_1, N2_1, Fs_1] = CreateFilter(Nbr);
[b_2, a_2, N1_2, N2_2, Fs_2] = CreateFilter(Nbr+1);
b = conv(b_1, b_2);
a = conv(a_1, a_2);
%% 1. ���������� h � ������� ������� filter � ������� �������
u_input_0 = [1, zeros(1, (N2_1))];
[u_out, k] = plotIC(b, a, u_input_0); % h1
%% 2. ���������� ������� ���� ����������� ������� �� ������� ������� �� ����������� x(n):
u_input_1 = input_2(Nbr, N2_1);
u_out = conv(u_input_1, u_out);
N2 = 45;
n = 0:(N2-1);
figure('Name','������� � �������� �������','NumberTitle', 'off')
subplot(2,1,1);
stem(n,u_input_1(1:N2),'fill','MarkerSize',3), grid;
xlabel('n'), ylabel('x(n)');
title('������� ������');
subplot(2,1,2);
stem(n,u_out(1:N2),'fill','MarkerSize',3), grid; xlabel('n'), ylabel('y(n)');
title('�������� ������ - conv (length = 45)')
%% 3. ������� �������
u_input_1 = input_2(Nbr, N2_1);
u_out = plotIC_1(b, a, u_input_1(1:45)); % h1
%% 4. ���������� ��� ���� ����������� ������� � ����� ������������� ������
w = 0:pi/100:pi; % ������ ������������� ������ (���)
H_w = freqz(b,a,w); % ����������� ����������� ��������
PHASE_w = angle(H_w); % ���
subplot(3,1,1);
plot(w,MAG_w), grid;
xlabel('w (rad)'), title('MAGNITUDE -|�(w)|')
subplot(3,1,2);
plot(w,PHASE_w), grid;
xlabel('w (rad)'), title('PHASE - arg[H(w)] (rad)')
subplot(3,1,3);
zplane(b,a), title('Z-plane zero-pole plot 1'), grid
xlabel('Re'), ylabel('jIm')
