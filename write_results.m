function uspeh = zapis_rezultatov(filename, rezultati, postfix);
if nargin == 2
    postfix = '_rezultati.txt';
end
%fid=fopen(strcat(filename,'_rezultati.txt'),'w');
fid=fopen(strcat(filename, postfix),'w');
uspeh = fid ~= -1;
if ~uspeh
    return
end
%{{1, 2, 3}, {-1, 3, 4}, ...
fprintf(fid,'%s','{');
[st_vprasanj, st_nalog] = size(rezultati);
for j=1:st_nalog-1    
    fprintf(fid,'%s','{');
    for i=1:st_vprasanj-1
          fprintf(fid,'%s%s%s','{"',num2str(rezultati(i, j), 17),'"},');
    end
    fprintf(fid,'%s%s%s','{"',num2str(rezultati(end,j), 17),'"}},');
end
fprintf(fid,'%s','{');
for i=1:st_vprasanj-1
    fprintf(fid,'%s%s%s','{"',num2str(rezultati(i,end), 17),'"},');
end
fprintf(fid,'%s%s%s','{"',num2str(rezultati(end,end), 17), '"}}}');
fclose(fid);