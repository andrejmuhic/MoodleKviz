function sucess = write_results(filename, results, postfix);
if nargin == 2
    postfix = '_rezultati.txt';
end
%fid=fopen(strcat(filename,'_rezultati.txt'),'w');
fid=fopen(strcat(filename, postfix),'w');
sucess = fid ~= -1;
if ~sucess
    return
end
%{{1, 2, 3}, {-1, 3, 4}, ...
fprintf(fid,'%s','{');
[n_questions, n_problems] = size(results);
for j=1:n_problems-1    
    fprintf(fid,'%s','{');
    for i=1:n_questions-1
          fprintf(fid,'%s%s%s','{"',num2str(results(i, j), 17),'"},');
    end
    fprintf(fid,'%s%s%s','{"',num2str(results(end,j), 17),'"}},');
end
fprintf(fid,'%s','{');
for i=1:n_questions-1
    fprintf(fid,'%s%s%s','{"',num2str(results(i,end), 17),'"},');
end
fprintf(fid,'%s%s%s','{"',num2str(results(end,end), 17), '"}}}');
fclose(fid);