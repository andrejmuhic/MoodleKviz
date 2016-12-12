function uspeh = zapis_vprasanj(filename, AnswerPrompt, postfix);
%filename ... koren datoteke
%AnswerPrompt  ... podvprasanja kot cell array stringov {'test', 'vprasanje', ...}
%postfix  ...  privzeto '_rezultati.txt'
if nargin == 2
    postfix = '_vprasanja.txt';
end
fid=fopen(strcat(filename,postfix),'w');
uspeh = fid ~= -1;
if ~uspeh
    return
end
dol=length(AnswerPrompt);
fprintf(fid,'%s','{');
for i=1:dol-1
    fprintf(fid,'%s%s',AnswerPrompt{i},',');
end
fprintf(fid,'%s%s',AnswerPrompt{end},'}');
fclose(fid);
