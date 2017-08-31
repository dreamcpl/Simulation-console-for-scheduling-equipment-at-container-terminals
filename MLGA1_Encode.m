function Cmi=MLGA1_Encode(Cmi,MLGA)
%%
for i=1:MLGA(1).ChmSum
       Cmi{2,i}=MLGA_Encode(Cmi{4,i});
end