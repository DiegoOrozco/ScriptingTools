BEGIN{
	FS = "[ ]+"
}
(NR > 1)
{
	++direccionesIP[$10] 
}
END{
	for(i in direccionesIP)
	printf "La direcci n %s ha intentado hacer login %d veces\n", i, direccionesIP [i]
}


