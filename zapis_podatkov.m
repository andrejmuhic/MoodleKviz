function uspeh = zapis_podatkov(filename, Podatki, postfix);
%filename ... koren datoteke
%Podatki  ... za vsako nalogo i so Podatki v i-tem stolpcu
%[1 -4  5  Prva naloga ima podatke   1, 3
% 3  5  7] Druga naloga ima podatke -4, 5
%Vprasanje i ... j - ta pojavitev `` v nizu se zamenja z j-tim elementom v i-tem stolpcu  
%postfix  ...  privzeto '_podatki.txt'
if nargin == 2
    postfix = '_podatki.txt';
end
%fid=fopen(strcat(filename,'_podatki.txt'),'w');
fid=fopen(strcat(filename, postfix),'w');
uspeh = fid ~= -1;
if ~uspeh
    return
end
dol=size(Podatki, 2);
niz = '{';
for j=1:dol
    %precision is lost here!!!!, warning
    raz = length(Podatki(:, j));
    niz = [niz, '{'];
    for i = 1 :raz-1
        niz = [niz, '"', num2str(Podatki(i, j), 17), '"', ', '];
    end
    niz = [niz, '"', num2str(Podatki(raz, j), 17), '"', '}, '];
%     niz = sprintf('%g,', Podatki(:, i));
%     %odstranimo zadnjo vejico
%     niz(end) = [];
%     fprintf(fid,'%s%d%s','{',Podatki(i),'},');
end
niz([end-1, end]) = ' }';
fprintf(fid, '%s', niz);
fclose(fid);