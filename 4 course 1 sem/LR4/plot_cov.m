function plot_cov(R, m, c)

% plot_cov(R, m, c)
%
% ?��������� �� ������� ������, ��������������� �������� ��������������
% ������� � ��������������� ��������.
%
% ?��������:
%   R - �������������? ������� (2�2)
%   m - ������ ����������? (2�1)
%   c - �������� ��? ������� plot

q = 0.5*atan2(2*R(1,2),R(1,1) - R(2,2));
a = sqrt(R(1,1)*cos(q)^2 + R(1,2)*sin(2*q) + R(2,2)*sin(q)^2);
b = sqrt(R(1,1)*sin(q)^2 - R(1,2)*sin(2*q) + R(2,2)*cos(q)^2);
t = 0:0.02:1;
s = [cos(q) -sin(q); sin(q) cos(q)] ...
    *[a*cos(2*pi*t); b*sin(2*pi*t)];
plot(s(1,:) + m(1), s(2,:) + m(2), c);

end