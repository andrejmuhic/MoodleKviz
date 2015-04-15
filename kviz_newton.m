%%XML kreiramo z Get["mdl_izpis_matlab.m"]
%ime datoteke
filename='kviz_newton';
%kategorijo bomo doloèili pri uvozu v moodle
%%
%%Kreiranje podatkov in zapis v obliki za Mathematico
format long;
%Ce hocemo zmeraj iste podatke, nastavimo konstantno seme
rand('state', 0);
%stevilo studentov
n = 40;
Podatki=round(200*rand(1,n));%zacetni indeks vrstice
%%Zapis podatkov v obliki za Mathematico ... {{3}, {4}, {5}}
zapis_podatkov(filename, Podatki);
%%
%%Kreiranje besedila naloge in zapis v obliki za Mathematico
%Pripravimo vrstico z vprasanjem
%Enojni narekovaj v nize, moramo eskajpati ''!
zac_text = 'seme = ``; rand(''state'', seme); k=2*rand(); raz=10^-3; n=4;';
QuestionTextMatlab=['Naj bo >> <br />',  zac_text, '<br />  Resujemo sistem:', ...
    '\(x^2+y^2=3-k, \quad -x^2+y^2+2xy =1.\)Odgovori na naslednja vprasanja: <br />'];
QuestionText = escape(QuestionTextMatlab);
zapis_besedila(filename, QuestionText);
%%
%%Kreiranje vprasanj naloge in zapis v obliki za Mathematico
%Nadleznemu escapanju se izognemo z uporabo funkcije escape_cell
AnswerPrompt={'<br/> Kaksna je x komponentna priblizka za resitev sistema po n korakih Newtonove metode, za zacetni priblizek \(x_0=1,~y_0=1\)?', ...
     '<br/> Kaksna je druga norma razlike dveh zaporednih priblizkov dobljenih z Newtonovo metodo, ko je norma razlike prvi manjsa kot raz? ', ...
     '<br/>(*) Pri kateri vrednosti parametra k se krivulji dotikata?'};
AnswerPrompt =  cellfun(@escape, AnswerPrompt, 'UniformOutput', false);
st_vprasanj=length(AnswerPrompt);
st_nalog=size(Podatki, 2);
zapis_vprasanj(filename, AnswerPrompt);
Utezi = ones(st_vprasanj, st_nalog); 
zapis_utezi(filename, Utezi);
%%
%%

%%Generiramo še odgovore za vsako nalogo
%Vsaka naloga je istega tipa, le z drugimi zaèetnimi podatki
%V tem primeru imamo dve vprašanji in ...
rezultati=zeros(st_vprasanj,st_nalog);

for j=1:st_nalog
    %evaluiramo zacetne podatke
    niz_eval = prepare_text(zac_text, Podatki(:, j));
    eval(niz_eval);
    F = @(X) [X(1).^2 + X(2).^2 - 3+k; 
             -X(1).^2+  X(2).^2 + 2*X(1).*X(2) - 1];
   JF = @(X) [2*X(1), 2*X(2); -2*X(1)+2*X(2), 2*X(1)+2*X(2)]; 
   x0 = [1; 1];
   rez = newtonk(F,JF,x0,0,n);
    %Zapis odgovora na prvo vprasanje v tabelo
    %prvi del
    rezultati(1,j)=rez(1);
    %drugi del
    [nicla, dif] = newtonk(F,JF,x0,raz,inf); 
    rezultati(2,j) = dif;
    rezultati(3,j) = 1/2*(6 - sqrt(2));

end
%%
%%Kreiranje rezultatov naloge in zapis v obliki za Mathematico
pot = '"C:\Program Files\Wolfram Research\Mathematica\10.0\math.exe"';
zapis_rezultatov(filename, rezultati);
stdecimalk = 5;
uspeh = generate_xml(filename, pot, stdecimalk);
%%