% Effect of Modulus Ratio E1/E2 on SCF
% ====================================

clear, clc, close all %#ok<*WNOFF>

Nu12 = 0.32; 
A1 = 0.34;     % Ga12/E2
CS = 1;
for th = 0 : 15 :90
   
    for H = [2 5 10 20 30 40 50 60 70 80 90 100]
        Nu21 = Nu12*(1/H);
        H1 =(0.5*(1/A1) - Nu21);
        H2 = 1/H;
        Ga1 = ( sqrt(  H1 + sqrt(H1^2 - H2) )-1 ) / ( sqrt(  H1 + sqrt(H1^2 - H2) )+1 );
        Ga2 = ( sqrt(  H1 - sqrt(H1^2 - H2) )-1 ) / ( sqrt(  H1 - sqrt(H1^2 - H2) )+1 );
        
        count =1;
        for a  = 0:.1:180
            Fac  = cosd(2*(a-th));
            Fac3 = sind(2*(a-th)) * sind(th) * cosd(th);
            Fac1 = 2*Ga1*cosd(2*(a-th));
            Fac2 = 2*Ga2*cosd(2*(a-th));
            
            G1 = ((1+Ga1)*(1+Ga2)) * (1+ Ga1 + Ga2 -(Ga1*Ga2) - 2*Fac);
            G2 = -4*((Ga1+Ga2) - (1+(Ga1*Ga2))*cosd(2*(a-th)))*(sind(th)^2);
            G3 = -4*((Ga1*Ga2)-1)*Fac3;
            G4 = (1+Ga1^2-Fac1)*(1+Ga2^2-Fac2);
            
            Sa(count)  =((G1+G2+G3 )/ G4);
            count = count + 1;
        end
        
        a_tension(CS)     = max(Sa); %#ok<*SAGROW>
        a_compresion(CS)  = min(Sa);
        CS = CS + 1;
    end
end


figure(2); hold on
A = [2 5 10 20 30 40 50 60 70 80 90 100];
m = length(A);
for i = 1 : 7
    if i == 1
        plot(A ,a_tension(1:m),'-^')
    else
        plot(A ,a_tension((m*(i-1))+1:m*i),'Marker','square')
    end
end
grid on
xlabel('E1/E2 ')
ylabel('SCF')
title('SCFs versus E1/E2 Effect of Modulus Ratio on SCF (TENSION)')
legend({'0°','15°','30°','45°','60°','75°','90°'},'Location','NorthWest')
hold off

H=gca;
H.LineWidth=1.5; 
set(gcf,'position',[10,10,400,350])

figure(3); hold on
for i = 1 : 7
    if i == 1
        plot(A ,a_compresion(1:m),'-^')
    else
        plot(A ,a_compresion((m*(i-1))+1:m*i),'Marker','square')
    end
end
grid on
xlabel('E1/E2 ')
ylabel('SCF')
title('SCFs versus E1/E2 Effect of Modulus Ratio on SCF (COMPRESION)')
legend({'0°','15°','30°','45°','60°','75°','90°'},'Location','SouthWest')

H=gca;
H.LineWidth=1.5; 
set(gcf,'position',[10,10,400,350])


