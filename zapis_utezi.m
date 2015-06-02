function uspeh = zapis_utezi(filename, utezi, postfix);
if nargin == 2
    postfix = '_utezi.txt';
end
%fid=fopen(strcat(filename,'_utezi.txt'),'w');
strcat(filename, postfix)
fid=fopen(strcat(filename, postfix),'w');
uspeh = fid ~= -1;
if ~uspeh
    return
end
%{{1, 2, 3}, {-1, 3, 4}, ...
fprintf(fid,'%s','{');
[st_vprasanj, st_nalog] = size(utezi);
for j=1:st_nalog-1    
    fprintf(fid,'%s','{');
    for i=1:st_vprasanj-1
          fprintf(fid,'%s%s%s','{',num2str(utezi(i, j), 17),'},');
    end
    fprintf(fid,'%s%s%s','{',num2str(utezi(end,j), 17),'}},');
end
fprintf(fid,'%s','{');
for i=1:st_vprasanj-1
    fprintf(fid,'%s%s%s','{',num2str(utezi(i,end), 17),'},');
end
fprintf(fid,'%s%s%s','{',num2str(utezi(end,end), 17), '}}}');
fclose(fid);