function uspeh = zapis_besedila(filename, QuestionText, postfix);
%filename ... koren datoteke
%QuestionText  ... niz za Mathematico z vprašanjem
%postfix  ...  privzeto '_besedilo.txt'
if nargin == 2
    postfix = '_besedilo.txt';
end

fid=fopen(strcat(filename,postfix),'w');
uspeh = fid ~= -1;
if ~uspeh
    return
end
fprintf(fid,'%s%s%s','{',QuestionText,'}');
fclose(fid);