
% Glass_Epoxy composite
% ========================

clear, clc %#ok<*SAGROW>
% Material properties
[Prop, ~ ] = Materials('Glass-Epoxy');
E1 = Prop(1); E2 = Prop(2);
Nu12 = Prop(3); Ga12 = Prop(4);
Nu21 = Nu12*E2/E1;


Sx = -1;  % SCFs Angle

CS = 1;
for th = 0 : 5 : 90 % Fiber Angle
    
    H1 =(E2/(2*Ga12)) - Nu21 ;
    H2 = E2/E1;
    Ga1 = ( sqrt(  H1 + sqrt(H1^2 - H2) )-1 ) / ( sqrt(  H1 + sqrt(H1^2 - H2) )+1 );
    Ga2 = ( sqrt(  H1 - sqrt(H1^2 - H2) )-1 ) / ( sqrt(  H1 - sqrt(H1^2 - H2) )+1 );
    
    count =1;
    for a  = 0:.01:180
        
        Fac  = cosd(2*(a-th));
        Fac3 = sind(2*(a-th)) * sind(th) * cosd(th);
        Fac1 = 2*Ga1*cosd(2*(a-th));
        Fac2 = 2*Ga2*cosd(2*(a-th));
        
        G1 = ((1+Ga1)*(1+Ga2)) * (1+ Ga1 + Ga2 -(Ga1*Ga2) - 2*Fac);
        G2 = -4*((Ga1+Ga2) - (1+(Ga1*Ga2))*cosd(2*(a-th)))*(sind(th)^2);
        G3 = -4*((Ga1*Ga2)-1)*Fac3;
        G4 = (1+Ga1^2-Fac1)*(1+Ga2^2-Fac2);
        
        Sa(count)  =((G1+G2+G3 )/ G4)*Sx;
        count = count + 1;
    end
    %
    a_tension(CS)     = max(Sa); 
    a_compresion(CS)  = min(Sa);
    CS = CS + 1;
end

[numbers1, ~ , ~] = xlsread('Glass-Epoxy in CM'); % IGA RESULTS

M_tension    = numbers1(:,2);
M_compresion = numbers1(:,3);


figure(3); hold on
A = 0:5:90;
plot(A ,a_tension,'-*')
plot(A ,a_compresion,'-o')

plot(A ,M_tension,'b-^')
plot(A ,M_compresion,'b-.')

grid on
xlabel('Angle (°)')
ylabel('SCF')
title('SCFs versus Angle for composite plates Glass/Epoxy')
legend({'Tension','Compresion'},'Location','NorthEast')