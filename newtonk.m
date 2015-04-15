function [y, ndeltax]=newtonk(F,JF,x0,delta,maxsteps)

% y=NEWTON(F,JF,x0,delta,maxsteps) dela Newtonovo metodo za funkcijo F in Jacobianom JF 
% z zacetnim priblizkom x0. 
% Primer:   f1(x, y) = x^2+y^2-4
%           f2(x, y) = x^2 - y^2 - 1
% a) Funkciji F in JF sta lahko podani v posebnih datotekah z istim imenom.
%    Klic: newton(@F,@JF,x0,delta,maxsteps)
% b) Funkciji F in JF sta lahko podani kot anonimni funkciji
%    F =  @(X) [X(1)^2 + X(2)^2 - 4; X(1)^2 - X(2)^2 - 1];
%    JF = @(X) [2*X(1),  2*X(2);
%               2*X(1), -2*X(2)]; 
%    Klic: newton(@F,@JF,x0,delta,maxsteps)
% Iteracija se konca, ko se zadnja priblizka absolutno razlikujeta za manj kot delta ali ko 
% prekoracimo maksimalno stevilo korakov maxsteps. Ce zadnjih dveh argumentov ne podamo, je 
% privzeta vrednost za delta osnovna zaokrozitvena napaka eps, za maxsteps pa 50.

% Andrej Muhiè 2015
if nargin<4, delta=eps; end
if nargin<5, maxsteps=50; end

xn=x0;
deltax = [1;1];
korak=0;                    						 
while (norm(deltax) > delta && (korak<maxsteps))
   korak=korak+1;           						 
   x0=xn;
   deltax=-JF(x0)\F(x0);
   xn=x0+deltax;
   disp(sprintf('%15.15f  ',xn'));
end   
ndeltax = norm(deltax);
y=xn;