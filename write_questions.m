function sucess = write_questions(filename, AnswerPrompt, postfix);
%filename ... prefix of the file
%AnswerPrompt  ...  subquestions as cell array of strings {'test', 'questions', ...}
%postfix  ...  defauls '_rezultati.txt'
if nargin == 2
    postfix = '_vprasanja.txt';
end
fid=fopen(strcat(filename,postfix),'w');
sucess = fid ~= -1;
if ~sucess
    return
end
n_answer=length(AnswerPrompt);
fprintf(fid,'%s','{');
for i=1:n_answer-1
    fprintf(fid,'%s%s',AnswerPrompt{i},',');
end
fprintf(fid,'%s%s',AnswerPrompt{end},'}');
fclose(fid);
