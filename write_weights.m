function sucess = write_weights(filename, weights, postfix);
if nargin == 2
    postfix = '_utezi.txt';
end
%fid=fopen(strcat(filename,'_utezi.txt'),'w');
strcat(filename, postfix)
fid=fopen(strcat(filename, postfix),'w');
sucess = fid ~= -1;
if ~sucess
    return
end
%{{1, 2, 3}, {-1, 3, 4}, ...
fprintf(fid,'%s','{');
[n_questions, n_problems] = size(weights);
for j=1:n_problems-1    
    fprintf(fid,'%s','{');
    for i=1:n_questions-1
          fprintf(fid,'%s%s%s','{',num2str(weights(i, j), 17),'},');
    end
    fprintf(fid,'%s%s%s','{',num2str(weights(end,j), 17),'}},');
end
fprintf(fid,'%s','{');
for i=1:n_questions-1
    fprintf(fid,'%s%s%s','{',num2str(weights(i,end), 17),'},');
end
fprintf(fid,'%s%s%s','{',num2str(weights(end,end), 17), '}}}');
fclose(fid);