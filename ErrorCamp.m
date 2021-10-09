clear ,clc

Kaltakci = [3.000 6.719 4.409 3.995 ];
Rht      = [3.037 6.649 4.468 4.061 ];
for i = 1:numel(Rht)
    Err(i) = (abs(Rht(i)- Kaltakci(i))/Kaltakci(i))*100;
end
fprintf('Err: Isotropic  Car/Epo  GFRP  Gla/Epo\n\n')
for i = 1:numel(Rht)
    fprintf('    %4.3f',Err(i))
end