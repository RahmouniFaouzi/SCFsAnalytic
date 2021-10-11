
% GFRP composite Stacking Sequence : [0°/30/60/90°]

% Tension Test :
%---------------

clear, clc, close all  %#ok<*SAGROW>

% Material GFRP properties
[Prop, ~ ] = Materials('GFRP');
E1 = Prop(1); E2 = Prop(2);
Nu12 = Prop(3); Ga12 = Prop(4);
Nu21 = Nu12*E2/E1;

Sx = 1;  % Applied Stress

T = 1; 
for th = [0,30,60, 90] % Fiber Angle
    
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
        
        Sa(count)  =((G1+G2+G3 )/ G4)/Sx;
        count = count + 1;
    end
    %
    F_Layers(T,:) = Sa;
    T= T + 1;
end
figure(1); hold on
line([0 180],[0 0]);  
A = 0:0.01:180;

for j = 1 : size( F_Layers,1)
    plot(A , F_Layers(j,:),'.')
end
grid on
xlabel('Alpha (°)') 
ylabel('SCF') 
title('SCFs versus Alpha for 4-layered composite plates GFRP TENSION')
legend({'LYR 1','LYR 2','LYR 3','LYR 4'},'Location','northwest')

%%

% Compression Test :
%-------------------

% Material GFRP properties
[Prop, STRENGHT] = Materials('GFRP');
E1 = Prop(1); E2 = Prop(2);
Nu12 = Prop(3); Ga12 = Prop(4);
Nu21 = Nu12*E2/E1;

Sx = -1;  % Applied Stress

T = 1; 
for th = [0,30,60, 90] % Fiber Angle
    
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
        
        Sa(count)  =((G1+G2+G3 )/ G4)/Sx; 
        count = count + 1;
    end
    %
    F_Layers(T,:) = Sa; % Store results 
    T= T + 1;
end
figure(2); hold on
line([0 180],[0 0]);  
A = 0:0.01:180;

for j = 1 : size( F_Layers,1)
    plot(A , F_Layers(j,:),'.')
end
grid on
xlabel('Alpha (°)') 
ylabel('SCF') 
title('SCFs versus Alpha for 4-layered composite plates GFRP Compression')
legend({'LYR 1','LYR 2','LYR 3','LYR 4'},'Location','northwest')