function D_izm = h_discret_dist2(D, dD, V)

% D_izm = h_discret_dist(D, V)
%
% ?��������� ���������� ��������� ��� ���������� ��������������,
% ������������� ����� ���������� �������������� �������.
% ?������������?, ��� �����������? ������� ������ � ����������� ������� 
% ����������� � ��� �������������. ?��������� ��������� ������?���? 
% ��� ������ ��������-���������� ������� �� �������� � 2-� �������, 
% ��������� � �������� ��������� D. ?������� �������� �������?���? 
% ��������� ���������? ������� � ���������������� ������ ��������� �������.
% ����� ����, � �������� ������������ ���������� ���, �������������
% �������� (?�?) �������? ���������� V.
% ?������ �������� D ����� ���� ��������.

  global H_DISCRET_DIST_ALG H_DISCRET_DIST_CORRECT;
  h_alg = 1;
  if ~isempty(H_DISCRET_DIST_ALG)
    h_alg = H_DISCRET_DIST_ALG;
  end
  
  h_corr = 0;
  if ~isempty(H_DISCRET_DIST_CORRECT)
    h_corr = H_DISCRET_DIST_CORRECT;
  end

  DD(1,:) = floor(D/dD)*dD;
  DD(2,:) = DD(1,:) + dD;
  if V > 0
    N = length(D);
    switch h_alg
      case 1    % �������� ������������� (������ �� ����� ���������)
    DW = sqrt([((DD(2,:)-D)/dD + V*randn(1,N)).^2 + (V*randn(1,N)).^2; ...
               ((D-DD(1,:))/dD + V*randn(1,N)).^2 + (V*randn(1,N)).^2]);
      case 2    % ������������� �������������
        DW = [((DD(2,:)-D)/dD + V*randn(1,N)).^2 + (V*randn(1,N)).^2; ...
              ((D-DD(1,:))/dD + V*randn(1,N)).^2 + (V*randn(1,N)).^2];
      case 3    % ���������� �������� �������������
        DW = abs([((DD(2,:)-D)/dD + V*randn(1,N)); ...
                  ((D-DD(1,:))/dD + V*randn(1,N))]);
    end
  else
    if h_alg == 2
      DW = [((DD(2,:)-D)/dD)^2; ((D-DD(1,:))/dD)^2];
  else
    DW = [(DD(2,:)-D)/dD; (D-DD(1,:))/dD];
  end
  end
  if h_corr ~= 0
    D_izm = 0.5*(DD(1,:) + DD(2,:)) + ...
            (1+V)^2*0.5*dD*(DW(2,:) - DW(1,:))./(DW(1,:) + DW(2,:));
  else
%   D_izm = (DD(1,:).*DW(1,:) + DD(2,:).*DW(2,:))./(DW(1,:) + DW(2,:));
    D_izm = DD(1,:) + dD*DW(2,:)./(DW(1,:) + DW(2,:));
%   D_izm = 0.5*(DD(1,:) + DD(2,:)) + ...
%             0.5*dD*(DW(2,:) - DW(1,:))./(DW(1,:) + DW(2,:));
  end
end
