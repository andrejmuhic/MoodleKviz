%Funkcija nam pripravi niz, da je primeren za Mathematico
function str = escape(str, znaki, narekovaj)
if nargin == 1
    znaki = '\\\';
end
if nargin <= 2
    narekovaj = '"';
end
if ~isempty(str)
    if str(1) == '"'
        str(1) = [];
    end
end
prazen = isempty(str);
if ~prazen
    if str(end) == '"'
        str(end) = [];
    end
end
    str = regexprep(str,'\',znaki);
    str = regexprep(str,'"','\\\"');
    str = close_as_Mathematica(str, narekovaj);
end


function str = close_as_Mathematica(str, narekovaj)
if isempty(str)
    return
end
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