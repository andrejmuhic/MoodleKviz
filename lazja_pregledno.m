%%XML kreiramo z Get["mdl_izpis_matlab.m"]
%ime datoteke
filename='kviz_lazja';
%kategorijo bomo doloèili pri uvozu v moodle
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
zac_text = 'seme=``;rand(''seed'',seme); a=rand(1)';
QuestionTextMatlab=['Naj bo >> </br> seme=``;rand(''seed'',seme); a=rand(1) </br>  Plocevina ima obliko ' ...
    'krivocrtnega trapeza, omejenega s premicami \(x=0\), \(x=1\), \(y=0\) in '...
    '\(y=\exp(-a(-\cos(\pi/2 * x) + 1))\).']; 
QuestionText = escape(QuestionTextMatlab);
zapis_besedila(filename, QuestionText);
%%
%%Kreiranje vprasanj naloge in zapis v obliki za Mathematico
%Nadleznemu escapanju se izognemo z uporabo funkcije escape_cell
AnswerPrompt={'<br/> Obseg krivocrtnega trapeza je  ',
    ['<br/> Pri kateri vrednosti \(x\) moramo prerezati plocevino vertikalno z ravnim rezom, '...
    'da razpade na dva dela v razmerju ploscin 1:2? \(x= \)']};
AnswerPrompt =  cellfun(@escape, AnswerPrompt, 'UniformOutput', false);
st_vprasanj=length(AnswerPrompt);
st_nalog=length(Podatki);
zapis_vprasanj(filename, AnswerPrompt);
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
    f=@(x) sqrt(1+( -1/2*a*pi*sin(pi/2*x) .* exp(-a*(-cos(pi/2*x)+1))).^2);
    el=quad(f,0,1);
    %Zapis odgovora na prvo vprasanje v tabelo
    rezultati(1,j)=el+1+1+exp(-a)  
    f=@(x) exp(-a*(-cos(pi/2*x)+1));
    g=@(z) quad(f,0,z)-1/2*quad(f,z,1);
    x0=fzero(g,1/2);
    %Zapis odgovora na drugo vprasanje v tabelo
    rezultati(2,j)=x0;
end
%%
%%Kreiranje rezultatov naloge in zapis v obliki za Mathematico
pot = '"C:\Program Files\Wolfram Research\Mathematica\10.0\math1.exe"';
zapis_rezultatov(filename, rezultati);
stdecimalk = 5;
uspeh = generate_xml(filename);
%%