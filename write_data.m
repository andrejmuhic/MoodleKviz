function uspeh = write_data(filename, Data, postfix);
%filename ... prefix of the file
%Data  ... every problem i corresponds to Data[:, i]
%[1 -4  5  First problem has data   1, 3
% 3  5  7] Second problem has data -4, 5
%Question i ... jth occurence of `` in the string is replaced with Data[j,i]
%postfix  ...  default '_podatki.txt'
if nargin == 2
    postfix = '_podatki.txt';
end
%fid=fopen(strcat(filename,'_podatki.txt'),'w');
fid=fopen(strcat(filename, postfix),'w');
uspeh = fid ~= -1;
if ~uspeh
    return
end
n_data=size(Data, 2);
niz = '{';
for j=1:n_data
    %precision is lost here!!!!, warning
    %this should be done in binary!
    len_j = length(Data(:, j));
    niz = [niz, '{'];
    for i = 1 :len_j-1
        niz = [niz, '"', num2str(Data(i, j), 17), '"', ', '];
    end
    niz = [niz, '"', num2str(Data(len_j, j), 17), '"', '}, '];
end
niz([end-1, end]) = ' }';
fprintf(fid, '%s', niz);
fclose(fid);