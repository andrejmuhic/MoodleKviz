function sucess = generate_xml(file_prefix, mathematica_path, n_decimals, category)
if nargin == 1
    mathematica_path = 'math.exe';
    %is math.exe on system path?
    [status,cmdout] = system([mathematica_path, ' -noprompt -run  "Exit[];"']);
    if status == 1
        %is math.exe on matlab path?
        if(exist(mathematica_path, 'file') == 2)
            mathematica_path = ['"',which(mathematica_path),'"'];
            [status,cmdout] = system([mathematica_path, ' -noprompt -run  "Exit[];"']);
        end
    end
    %no path for matlab.exe is available!
    if status == 1
        error('math.exe was not found, provide full path!');
        sucess = false;
        return;
    end
    category = 'test';
end
if nargin >= 2
    %%correct user provide path, close it with " if needed
   if mathematica_path(1) ~= '"'
       mathematica_path = ['"', mathematica_path];
   end
   if mathematica_path(end) ~= '"'
       mathematica_path = [mathematica_path, '"'];
   end
   %%
   %checking if path to math.exe is valid
   [status,cmdout] = system([mathematica_path, ' -noprompt -run  "Exit[];"']);
   %It is not valid if status = 1!
    if status == 1
        error('math.exe was not found, provide correct full path!');
        sucess = false;
        return;
    end
end
% else
%     if mathematica_pot(1) ~= '!'
%         mathematica_pot = ['!', mathematica_pot];
%     end
% end
if nargin < 3
    %Relativna natancnost je privzeto 10^-3
    n_decimals = 3;
    category = 'test';
end;    

if nargin == 3
    category = 'test';
end
sucess = false;
mathematica =  [mathematica_path, ' -noprompt -run ']; 
MathematicaPackage = escape(which('mdl_out_matlab.m'), '/', '\"')
pot = escape([cd, '/'], '/', '\"')
%pot = escape([pathstr, '/'], '/', '\"');
%pot
file_prefix = escape(file_prefix, '/', '\"');
category = escape(category, '/', '\"');
run_niz = [mathematica, '"', 'direktorij=',  pot '; ', 'MathematicaPackage=', MathematicaPackage, '; ', 'koren=',  file_prefix, ';',  ' stdecimalk', '=', int2str(n_decimals), ';', ...
    ' kategorija', '=', category, ';', 'filename = direktorij <> koren; Get[MathematicaPackage];', 'Exit[];', '"'];
mathematica
run_niz
%eval(run_niz);
[status,cmdout] = system(run_niz);
if status == 0
    sucess = true;
end
