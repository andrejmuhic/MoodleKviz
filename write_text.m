function uspeh = write_text(filename, QuestionText, postfix)
%filename ... prefix of the file
%QuestionText  ...  string for Mathematica containig questions
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