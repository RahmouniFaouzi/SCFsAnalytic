function [Prop, STRENGHT] = Materials(MAT)

switch MAT

    % Ref: {Bhatnagar N et al. Determination of machining-induced damage characteristics of fiber reinforced 
	% plastic composite laminates. Mater Manuf Processes}
    case 'GFRP' %Glass Fiber Reinforced Polymer
        E1 = 48e3; E2 = 12e3;
        nu12 = 0.19; G12 = 6e3;
        nu21 = nu12*E2/E1;
        Prop = [E1  E2  nu12  G12  nu21];
        STRENGHT = [1200 59 800 128 25];
    
    % Ref: {Design Optimization and Non-Linear Buckling Analysis of Spherical Composite Submersible Pressure Hull}
    case 'carbon-epoxy'
        E1   = 121E3; E2  = 8.6E3;
        nu12 = 0.27;  G12 = 4.7E3;
        nu21 = nu12*E2/E1;
        Prop = [E1  E2  nu12  G12  nu21];
        STRENGHT = [2231 29 1082 100 60];
		
    % ref:{Kaltakci1996}
    case 'Glass-Epoxy'
        E1 = 54.9e3; E2 = 18.3e3;
        nu12 = 0.25; G12 = 9.14e3;
        nu21 = nu12*E2/E1;
        Prop = [E1  E2  nu12  G12  nu21];
        STRENGHT = [1055.5 28.1 1055.5  140.7 42.2];
        
    otherwise
        disp('Material Not Found Cheek Inputs and Try Again')
end

end


