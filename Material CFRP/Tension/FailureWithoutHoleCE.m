% Failure of CFRP without hole 
%----------------------------------------

clear, clc %#ok<*SAGROW>

% Material GFRP properties
[Prop, STRENGHT] = Materials('GFRP');
E1 = Prop(1); E2 = Prop(2);
Nu12 = Prop(3); G12 = Prop(4);
Nu21 = Nu12*E2/E1;

% Strenght Properties
X = STRENGHT(1); Y  = STRENGHT(2);
X1= STRENGHT(3); Y1 = STRENGHT(4);
D = STRENGHT(5);

Sx = 1;  % Applied Stress

K1 = E1*(1+ Nu21); K2 = E2*(1+ Nu12);
K3 = sqrt(E1*E2*(1+ Nu12)*(1+ Nu21));
K = (K1 + K2)/(2*K3);

count = 1;
for th = 90:(-5):0  % Fiber Angle
    
    
    % Failure Stress
    % ==============
    
    S1 =  Sx * sind(th)^2;
    S2 =  Sx * cosd(th)^2;
    S3 = -Sx * sind(th) * cosd(th);
    
    F1 = S1^2   *(1/X^2);
    F2 = S2^2   *(1/Y^2);
    F3 = S3^2   *(1/D^2);
    F4 =(S1*S2) *(1/X^2);
    F5 = K *((S1*S2)/(X*Y));
    
    OfHR(count) = sqrt( 1/( F2+F3 )); if (th == 90), OfHR(count) = 1E+10;end
    OfTH(count) = sqrt( 1/(F1+F2+F3-F4));
    OfHV(count) = sqrt( 1/(F1+F2+F3-F5));
    
    
    fprintf('==> Angle is  = %4.3f \n', 90-th)
    fprintf('==> Stress_Failure \n\n')
    disp('Hashin-Rotem criterion')
    fprintf('==> Stress_Failure    = %4.3f \n', OfHR(count))
    
    disp('Tsai-Hill criterion')
    fprintf('==> Stress_Failure    = %4.3f \n', OfTH(count))
    
    disp('Hencky-Von Mises criterion')
    fprintf('==> Stress_Failure    = %4.3f \n', OfHV(count))
    disp('====================================================================')
    
    count = count +1;
end 

Ang = [0:5:90]';OfHR = OfHR'; OfTH = OfTH'; OfHV = OfHV';
Tab  = table(Ang, OfHR, OfTH, OfHV);
filename = 'Failure_CFRP_Without_Hole.xlsx';
writetable(Tab,filename,'Sheet',1,'Range','A2')



