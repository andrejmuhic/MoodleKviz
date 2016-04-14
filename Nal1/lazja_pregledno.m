current_dir = cd;
cd ..;
addpath(cd);
cd(current_dir);
%%XML kreiramo z Get["mdl_izpis_matlab.m"]
%ime datoteke
filename='kviz_lazja';
%kategorijo bomo doloèili pri uvozu v moodle
kategorija = 'Andrej_Muhic\Lazja\Nal1';
%%
%%Kreiranje podatkov in zapis v obliki za Mathematico
format long;
%Ce hocemo zmeraj iste podatke, nastavimo konstantno seme
rand('state', 0);
Podatki=round(200*rand(1,15));
%%Zapis podatkov v obliki za Mathematico ... {{3}, {4}, {5}}
zapis_podatkov(filename, Podatki);
%%
%%Kreiranje besedila naloge in zapis v obliki za Mathematico
%Pripravimo vrstico z vprasanjem
%Enojni narekovaj v nize, moramo eskajpati ''!
zac_text = 'seme=``;rand(''seed'',seme); A=rand(1000);';
QuestionTextMatlab=['Naj bo >> </br> seme=``;rand(''seed'',seme); </br>', ...
    '<img src="http://s22.postimg.org/uaf83tuap/Potencna.png" />'];
QuestionText = escape(QuestionTextMatlab);
zapis_besedila(filename, QuestionText);
%%
%%Kreiranje vprasanj naloge in zapis v obliki za Mathematico
%Nadleznemu escapanju se izognemo z uporabo funkcije escape_cell
AnswerPrompt={'<br/> \[ \sum_{i=6}^{1000} a_{1006-i, i}=  \]',
     '<br/> \[ \max_{1 \leq i \leq 1000} \sum_{j=1}^{1000} |a_{ji}|= \]',
    '<br/> Vsota tistih elementov v matriki A, katerih produkt indeksov je manjsi ali enak 1000, je:',
    '<br/> Vsota indeksov elementa v matriki A, ki je najblizje 1/2, je :'};
AnswerPrompt =  cellfun(@escape, AnswerPrompt, 'UniformOutput', false);
st_vprasanj=length(AnswerPrompt);
st_nalog=length(Podatki);
zapis_vprasanj(filename, AnswerPrompt);
%Tukaj lahko dolocis, da imajo razlicne tocke razlicno utez
Utezi = ones(st_vprasanj, st_nalog); 
zapis_utezi(filename, Utezi);
%%

%%Generiramo še odgovore za vsako nalogo
%Vsaka naloga je istega tipa, le z drugimi zaèetnimi podatki
%V tem primeru imamo dve vprašanji in ...
rezultati=zeros(st_vprasanj,st_nalog);

for j=1:st_nalog
    %seme=Podatki(:, j); rand('seed',seme); a=rand(1);
    %evaluiramo zacetne podatke
    niz_eval = prepare_text(zac_text, Podatki(:, j));
    eval(niz_eval);
    %Zapis odgovora na prvo vprasanje v tabelo
    vsota = 0;
    for i = 6 : 1000
        vsota = vsota + A(1006-i, i);
    end
    rezultati(1,j)=vsota;
    %Zapis odgovora na drugo vprasanje v tabelo
    rezultati(2,j)=norm(A, 1);
    %Zapis odgovora na tretjo vprasanje v tabelo
    n = length(A);
    ind = 1 : n;
    maska = ind'*ind <= 1000;
    rezultati(3,j)=sum( sum(maska.*A));
    %Zapis odgovora na cetrto vprasanje v tabelo
    [m, ind] = min( abs(A(:) - 1/2) );
    [xi, xj] = ind2sub(size(A), ind);
    rezultati(4,j) = sum([xi, xj]);
end
%%
%%Kreiranje rezultatov naloge in zapis v obliki za Mathematico
pot = '"C:\Program Files\Wolfram Research\Mathematica\10.4\math.exe"';
zapis_rezultatov(filename, rezultati);
rel_natancnost = 5;
uspeh = generate_xml(filename, pot, rel_natancnost, kategorija);

%%