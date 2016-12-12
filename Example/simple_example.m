current_dir = cd;
cd ..;
addpath(cd);
cd(current_dir);
%%XML is created by Get["mdl_izpis_matlab.m"]
%Name of the file
filename='simple_example';
%Category can be specified here
category = 'Andrej_Muhic\Lazja\Nal1';
%%
%%Creation of the data for Mathematica
format long;
%If you want the constant data fix the random state!
rand('state', 0);
Data=round(200*rand(1,15));
%%Data format suitable for Mathematica ... {{3}, {4}, {5}}
write_data(filename, Data);
%%
%%Creation of question text for Mathematica
%The row with the questions
%Escape single quotes using escape function ' -> ''!
raw_text = 'seme=``;rand(''seed'',seme); A=rand(1000);';
QuestionTextMatlab=['Naj bo >> </br> seme=``;rand(''seed'',seme); </br>', ...
    '<img src="http://s22.postimg.org/uaf83tuap/Potencna.png" />'];
QuestionText = escape(QuestionTextMatlab);
write_text(filename, QuestionText);
%%
%%Creation of answer prompt for questions
%Use escape_cell 
AnswerPrompt={'<br/> \[ \sum_{i=6}^{1000} a_{1006-i, i}=  \]',
     '<br/> \[ \max_{1 \leq i \leq 1000} \sum_{j=1}^{1000} |a_{ji}|= \]',
    '<br/> Sum all element in A that have product of indices less than equal to 1000 is:',
    '<br/> Sum of the indices of the element in  A which is closest to 1/2 is :'};
AnswerPrompt =  cellfun(@escape, AnswerPrompt, 'UniformOutput', false);
n_questions=length(AnswerPrompt);
n_problems=length(Data);
write_questions(filename, AnswerPrompt);
%Write weights
Weights = ones(n_questions, n_problems); 
write_weights(filename, Weights);
%%

%%Generate answers
%Every problem is of the same type but with different data
results=zeros(n_questions,n_problems);

for j=1:n_problems
    %%Replace `` with the Data(:, j)
    niz_eval = prepare_text(raw_text, Data(:, j));
    %%Evaluate the expression to generate data
    eval(niz_eval);
    %Answer to the first question
    vsota = 0;
    for i = 6 : 1000
        vsota = vsota + A(1006-i, i);
    end
    results(1,j)=vsota;
    %Answer to the second question
    results(2,j)=norm(A, 1);
    %Answer to the third question
    n = length(A);
    ind = 1 : n;
    mask = ind'*ind <= 1000;
    results(3,j)=sum( sum(mask.*A));
    %Answer to the fourth question
    [m, ind] = min( abs(A(:) - 1/2) );
    [xi, xj] = ind2sub(size(A), ind);
    results(4,j) = sum([xi, xj]);
end
%%
%%Creation of the results and passing data to mathematica quiz generator
%Linux example of the path
path_to_Mathematica_exec = '/home/andrej/Software/bin/math';
write_results(filename, results);
rel_prec = 5;
success = generate_xml(filename, path_to_Mathematica_exec, rel_prec, category);

%%