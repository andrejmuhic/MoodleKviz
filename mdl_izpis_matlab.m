(* ::Package:: *)

(*  cloze form for numerical question 
    http://docs.moodle.org/en/Numerical_question_type  *)
(* format for numerical questions. It calculates error relative to result *)
(*input files*)
(*Text ... FileName*)
besedilo=StringJoin[filename,"_besedilo.txt"];
(*Questions ... FileName*)
vprasanja=StringJoin[filename,"_vprasanja.txt"];
(*Data aka variable input ... FileName*)
podatki=StringJoin[filename,"_podatki.txt"];
(*Weights for questions  ... FileName*)
utezi=StringJoin[filename,"_utezi.txt"]; 
(*Final results ... FileName*)
rezultati=StringJoin[filename,"_rezultati.txt"];


(* This part of code is deprecated as it has troubles with UTF8
fid=OpenRead[besedilo];
QuestionText=Read[besedilo];*)
(*Read Text*)
fid = StringToStream[Import[besedilo]];
QuestionText=Read[fid];
QuestionText=QuestionText[[1]];
Close[fid];

(*
fid=OpenRead[vprasanja];
AnswerPrompt=Read[vprasanja];*)
(*Read Questions*)
fid = StringToStream[Import[vprasanja]];
AnswerPrompt=Read[fid];
Close[fid];

(*
fid=OpenRead[podatki];
Podatki=Read[podatki];*)
(*Read Data aka variable input*)
fid = StringToStream[Import[podatki]];
Podatki=Read[fid];
Close[fid];

fid = StringToStream[Import[utezi]];
Utezi=Read[fid];
Close[fid];

fid = StringToStream[Import[podatki]];
Podatki=Read[fid];
Close[fid];
(*
fid=OpenRead[rezultati];
Rezultati=Read[rezultati];*)
(*Read Final results *)
fid = StringToStream[Import[rezultati]];
Rezultati=Read[fid];
Close[fid];



(* Chop[expr]	replace all approximate real numbers in expr with magnitude less than 10^(-10) by 0 *)
(* RELATIVE ERROR result should be less than 10^-3... *)
RelError[r_] := StringJoin["1e", ToString[-stdecimalk]]
(*If[Chop[r] == 0, 0.1, CForm[10.^Floor[Log[10,Abs[r]]-stdecimalk]], CForm[10.^Floor[Log[10,Abs[r]]-stdecimalk]]]*)
(* ClozeForm from result as a pure function *)
(*ClozeForm[number_, weight_:{1}]:="{"<>TextString[First[weight]]<>":NUMERICAL:="<>TextString[NumberForm[Internal`StringToDouble[ First[number] ] , 16]]<>":"<>TextString[RelError[Internal`StringToDouble[First[number]]]]<>"}";*)
ClozeForm[number_, weight_:{1}]:="{"<>TextString[First[weight]]<>":NUMERICAL:="<> number<> ":"<>TextString[RelError[Internal`StringToDouble[First[number]]]]<>"}";
PocistiString[s_]:=StringReplace[s,"\\\\"->"\\cr"];
String2Form[s_,l___]:=Fold[StringReplace[#1,"``" -> #2,1]&,s,{l}];
FileNaloge=String2Form["``.xml",filename];
FilePtr=OpenWrite[FileNaloge,CharacterEncoding->"UTF8"];
(*quiz header*)
WriteString[FilePtr,"<?xml version=\"1.0\"?>\n"];
WriteString[FilePtr,"<quiz>\n\n\n"];
(*insert question code into this category*)
WriteString[FilePtr,"  <question type=\"category\">\n"];
WriteString[FilePtr,"    <category><text><![CDATA[$course$/",kategorija,"]]></text></category>\n"];
WriteString[FilePtr,"  </question>\n\n"];
(*description type question with question code inside*)
WriteString[FilePtr,"<!-- question: 1  -->\n"];
WriteString[FilePtr,"  <question type=\"description\">\n"];
WriteString[FilePtr,"    <name><text><![CDATA[",ime,"]]></text></name>\n"];
WriteString[FilePtr,"    <questiontext format=\"html\">\n"];
WriteString[FilePtr,"<text><![CDATA[",koda,"]]></text>\n"];
WriteString[FilePtr,"    </questiontext>\n"];
WriteString[FilePtr,"    <image></image>\n"];
WriteString[FilePtr,"    <generalfeedback>\n"];
WriteString[FilePtr,"<text></text>\n"];
WriteString[FilePtr,"    </generalfeedback>\n"];
WriteString[FilePtr,"    <defaultgrade>0</defaultgrade>\n"];
WriteString[FilePtr,"    <penalty>0</penalty>\n"];
WriteString[FilePtr,"    <hidden>0</hidden>\n"];
WriteString[FilePtr,"    <shuffleanswers>0</shuffleanswers>\n"];
WriteString[FilePtr,"</question>\n\n"];
(*insert questions into this category*)
WriteString[FilePtr,"  <question type=\"category\">\n"];
WriteString[FilePtr,"    <category><text><![CDATA["<>kategorija<>"]]></text></category>\n"];
WriteString[FilePtr,"  </question>\n\n"];
(*questions* /@ is Map*, @@ is Apply, @ is replace Header*)
For[i=1,i<=Length[Podatki],i++,
    (*question header*)
    WriteString[FilePtr,"<!--question:",i,"-->\n"];
    WriteString[FilePtr,"  <question type=\"cloze\">\n"];
    WriteString[FilePtr,"    <name><text><![CDATA[",ime," ",i,"]]></text></name>\n"];
    WriteString[FilePtr,"    <questiontext>\n"];
    WriteString[FilePtr,"<text><![CDATA["];
    (*question text*)
    (*PodStr=ToString/@TeXForm/@Podatki[[i]];*)
    nat = NumberForm[#1, 16] &;
    PodStr=ToString/@Podatki[[i]];
    VprStr=String2Form@@Join[{QuestionText},PodStr];
    WriteString[FilePtr,VprStr//PocistiString];
    (*question answer boxes*)
    WriteString[FilePtr,"\n\n"];
    For[j=1,j<=Length[Rezultati//Transpose],j++,
        WriteString[FilePtr,AnswerPrompt[[j]]];
        WriteString[FilePtr,TextString[ ClozeForm[ Rezultati[[i]][[j]], Utezi[[i]][[j]]] ] ];
    ];
    (*question footer*)
    WriteString[FilePtr,"\n\n]]></text>\n"];
    WriteString[FilePtr,"    </questiontext>\n"];
    WriteString[FilePtr,"    <shuffleanswers>0</shuffleanswers>\n"];
    WriteString[FilePtr,"  </question>\n"];
];
(*quiz footer*)
WriteString[FilePtr,"</quiz>\n"];
Close[FilePtr];
