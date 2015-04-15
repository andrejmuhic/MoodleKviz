function uspeh = generate_xml(koren_datoteke, mathematica_pot, stdecimalk)
if nargin == 1
    mathematica_pot = 'math.exe';
    %is math.exe on system path?
    [status,cmdout] = system([mathematica_pot, ' -noprompt -run  "Exit[];"']);
    if status == 1
        %is math.exe on matlab path?
        if(exist(mathematica_pot, 'file') == 2)
            mathematica_pot = ['"',which(mathematica_pot),'"'];
            [status,cmdout] = system([mathematica_pot, ' -noprompt -run  "Exit[];"']);
        end
    end
    %no path for matlab.exe is available!
    if status == 1
        error('math.exe was not found, provide full path!');
        uspeh = false;
        return;
    end
end
if nargin >= 2
    %%correct user provide path, close it with " if needed
   if mathematica_pot(1) ~= '"'
       mathematica_pot = ['"', mathematica_pot];
   end
   if mathematica_pot(end) ~= '"'
       mathematica_pot = [mathematica_pot, '"'];
   end
   %%
   %checking if path to math.exe is valid
   [status,cmdout] = system([mathematica_pot, ' -noprompt -run  "Exit[];"']);
   %It is not valid if status = 1!
    if status == 1
        error('math.exe was not found, provide correct full path!');
        uspeh = false;
        return;
    end
end
% else
%     if mathematica_pot(1) ~= '!'
%         mathematica_pot = ['!', mathematica_pot];
%     end
% end
if nargin < 3
    stdecimalk = 3;
end;    
uspeh = false;
mathematica =  [mathematica_pot, ' -noprompt -run ']; 
MathematicaPackage = escape(which('mdl_izpis_matlab.m'), '/', '\"')
pot = escape([cd, '/'], '/', '\"')
%pot = escape([pathstr, '/'], '/', '\"');
%pot
koren_datoteke = escape(koren_datoteke, '/', '\"');
run_niz = [mathematica, '"', 'direktorij=',  pot '; ', 'MathematicaPackage=', MathematicaPackage, '; ', 'koren=',  koren_datoteke, ';',  ' stdecimalk', '=', int2str(stdecimalk), ';', ...
    'filename = direktorij <> koren; Get[MathematicaPackage];', 'Exit[];', '"'];
run_niz
%eval(run_niz);
[status,cmdout] = system(run_niz);
if status == 0
    uspeh = true;
end
