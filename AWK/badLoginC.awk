BEGIN
{
	FS = "[ ]+"
}
(NR > 1)
{
	++direccionesIP[$10]
} 
END
{
	PROCINFO["sorted_in"]="@val_num_desc" count = 0;
	for(i in direccionesIP)
	{
		++ count
		if (count <= 10) 
		{
			printf "La direcci n %-15s ha intentado hacer login %d veces\n", i, direccionesIP[i]
			ip = i
			expresion = "address"
			command = "whois " ip " | grep -P ’[Aa]ddress\|[Cc]ountry\|Org\| *[Nn]ame\| remarks ’"
			while ( ( command | getline datos) > 0) 
				print datos
			
			printf"\n" 
		}
	} 
}