clear, clc %#ok<*SAGROW>

% Material carbon-epoxy properties
[Prop, STRENGHT] = Materials('carbon-epoxy');
E1 = Prop(1); E2 = Prop(2);
Nu12 = Prop(3); Ga12 = Prop(4);
Nu21 = Nu12*E2/E1;

% Strenght Properties
X = STRENGHT(1); Y  = STRENGHT(2);
X1= STRENGHT(3); Y1 = STRENGHT(4);  
D = STRENGHT(5); 

Sx = 1;  % Applied Stress

K1 = E1*(1+ Nu21); K2 = E2*(1+ Nu12);
K3 = sqrt(E1*E2*(1+ Nu12)*(1+ Nu21));
K = (K1 + K2)/(2*K3);

Sa1 = zeros(1,181); CS = 1;
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
        
        Sa1(count)  =((G1+G2+G3 )/ G4)/Sx; % SCFs 
        count = count + 1;
    end
    %
    a_tension(CS,1)     = max(Sa1); 
    a_compresion(CS,1)  = min(Sa1);
    Tension           = find(Sa1 == a_tension(CS,1))/100 - 0.01;
    Compresion        = find(Sa1 == a_compresion(CS,1))/100 - 0.01;
    tension_Ang(CS,1)   = Tension(1);
    compresion_Ang(CS,1)= Compresion(1);
    
    
    % Failure Stress
    % ==============
    HR = 1; TH = 1; HV = 1;
    OfHR_min = 1e10;   OfTH_min = 1e10; OfHV_min = 1e10;
    for i = 1:length(Sa1)
        Sa = Sa1(i);
        a1  = find(Sa1 == Sa)/100 - 0.01;
        
        a = a1(1);
        S1 =  Sa * sind(a-th)^2;
        S2 =  Sa * cosd(a-th)^2;
        S3 = -Sa * sind(a-th) * cosd(a-th);
        
        F1 = S1^2   *(1/X^2);
        F2 = S2^2   *(1/Y^2);
        F3 = S3^2   *(1/D^2);
        F4 =(S1*S2) *(1/X^2);
        F5 = K *((S1*S2)/(X*Y));
        
        OfHR(i) = sqrt( 1/( F2+F3 ));
        OfTH(i) = sqrt( 1/(F1+F2+F3-F4));
        OfHV(i) = sqrt( 1/(F1+F2+F3-F5));
        
        if OfHR_min > OfHR(i)
            Failure_AngleHR  = a;
            OfHR_min         = OfHR(i);
        end
        
        if OfTH_min > OfTH(i)
            Failure_AngleTH  = a;
            OfTH_min         = OfTH(i);
        end
        
        if OfHV_min > OfHV(i)
            Failure_AngleHV  = a;
            OfHV_min         = OfHV(i);
        end
        
    end
    
    Failure_HR(CS,1) =  OfHR_min; Failure_Ang_HR (CS,1) = Failure_AngleHR;
    Failure_TH(CS,1) =  OfTH_min; Failure_Ang_TH (CS,1) = Failure_AngleTH;
    Failure_HV(CS,1) =  OfHV_min; Failure_Ang_HV (CS,1) = Failure_AngleHV;
    
    fprintf('==> Fiber Angle = %1.f <== \n\n',th)
    fprintf('==> Max tensile SCF = %2.5f in Angle %2.3f \n',a_tension(CS,1),tension_Ang(CS,1))
    fprintf('==> Max compresion SCF = %2.5f in Angle %2.3f \n\n',a_compresion(CS,1),compresion_Ang(CS,1))
    
    fprintf('==> Stress_Failure \n\n')
    disp('Hashin-Rotem criterion')
    fprintf('==> Stress_Failure    = %4.3f \n',OfHR_min)
    fprintf('==> Angle_of_Failure  = %4.3f \n\n',Failure_AngleHR)
    
    disp('Tsai-Hill criterion')
    fprintf('==> Stress_Failure    = %4.3f \n',OfTH_min)
    fprintf('==> Angle_of_Failure  = %4.3f \n\n',Failure_AngleTH)
    
    disp('Hencky-Von Mises criterion')
    fprintf('==> Stress_Failure    = %4.3f \n',OfHV_min)
    fprintf('==> Angle_of_Failure  = %4.3f \n\n',Failure_AngleHV)
    CS = CS +1;
    disp('====================================================================')
end
Material_GR =0 : 5 : 90;
Tab  = table(Material_GR',a_tension ,tension_Ang, a_compresion, compresion_Ang , Failure_HR,...
              Failure_Ang_HR ,Failure_TH ,Failure_Ang_TH ,Failure_HV ,Failure_Ang_HV);
filename = 'Material_carbon_epoxy in Tension.xlsx';
writetable(Tab,filename,'Sheet',1,'Range','A2')

