%Funkcija nam pripravi niz, da je primeren za Mathematico
function str = escape(str, znaki, narekovaj)
if nargin == 1
    znaki = '\\\';
end
if nargin <= 2
    narekovaj = '"';
end
    str = regexprep(str,'\',znaki);
    str = close_as_Mathematica(str, narekovaj);
end


function str = close_as_Mathematica(str, narekovaj)
if nargin == 1
    narekovaj = '"';
end
    if str(1) ~= narekovaj
        str = [narekovaj, str];
    end
    if str(end) ~= narekovaj
        str = [str, narekovaj];
    end
end