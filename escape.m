%Prepare the string so that is suitable for mathematica
function str = escape(str, chars, quote)
if nargin == 1
    chars = '\\\';
end
if nargin <= 2
    quote = '"';
end
if ~isempty(str)
    if str(1) == '"'
        str(1) = [];
    end
end
is_empty = isempty(str);
if ~is_empty
    if str(end) == '"'
        str(end) = [];
    end
end
    str = regexprep(str,'\',chars);
    str = regexprep(str,'"','\\\"');
    str = close_as_Mathematica(str, quote);
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