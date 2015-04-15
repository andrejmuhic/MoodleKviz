function niz_eval = prepare_text(niz_eval, podatki)
%Zamenjamo vse ponovitve `` z ustreznimi vrednostmi podatkov
%podatki = [3, 4]
%'a = ``; b = ``;' --->  'a = 3; b = 4;'
znak = '`';
pred = false;
j = 1; i = 1;
%Zelo zelo pocasi, vem :)
while i <= length(niz_eval)
    if niz_eval(i) == znak
        if pred
            pred = false;
            niz_eval = [niz_eval(1:(i-2)), num2str(podatki(j)), niz_eval((i+1):end)];
            j = j + 1;
        else
            pred = true;
        end
    end
    i = i + 1;
end