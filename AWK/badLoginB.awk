BEGIN
{
	FS = "[ ]+"
}
(NR > 1)
{ 
	PROCINFO["sorted_in"]="@val_num_desc" ++direccionesIP[$10]
} 
END
{
	PROCINFO["sorted_in"]="@val_num_desc"
	for(i in direccionesIP)
	printf "La direcci n %-15s ha intentado hacer login %d veces\n", i, direccionesIP[i]
}
