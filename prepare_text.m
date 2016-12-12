function niz_eval = prepare_text(niz_eval, data)
%Replace all occurences of  `` with aprropriate data values
%podatki = [3, 4]
%'a = ``; b = ``;' --->  'a = 3; b = 4;'
char = '`';
pred = false;
j = 1; i = 1;
%Slow but not worth to optimize :)
while i <= length(niz_eval)
    if niz_eval(i) == char
        if pred
            pred = false;
            niz_eval = [niz_eval(1:(i-2)), num2str(data(j)), niz_eval((i+1):end)];
            j = j + 1;
        else
            pred = true;
        end
    end
    i = i + 1;
end