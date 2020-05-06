BEGIN{
FS = "\t"
	mayor_densidad = 0
	nombre_mayor_densidad = "a"

	menor_densidad = 1000000
	nombre_menor_densidad= "a"

	mayor_porcentaje = 0
	nombre_mayor_porcentaje= "a"

	menor_porcentaje = 100000
	nombre_menor_porcentaje= "a"

}


(NR > 1) {
	densidad = $2 / $4
	porcentaje = $3 * 100 / ($3 + $4)

	if ( mayor_densidad < densidad )
	{
		mayor_densidad = densidad
		nombre_mayor_densidad = $1
	}
	if ( menor_densidad > densidad )
	{
		menor_densidad = densidad
		nombre_menor_densidad = $1
	}

	if ( mayor_porcentaje < porcentaje )
	{
		mayor_porcentaje = porcentaje
		nombre_mayor_porcentaje = $1
	}
	if ( menor_porcentaje > porcentaje )
	{
		menor_porcentaje = porcentaje
		nombre_menor_porcentaje = $1
	}

	printf "%20s \t %f \t %f\n", $1, densidad, porcentaje

}

END {
	printf "Mayor densidad de población: %s con %f hab/millaˆ2\n", nombre_mayor_densidad, mayor_densidad
	printf "Menor densidad de población: %s con %f hab/millaˆ2\n", nombre_menor_densidad, menor_densidad
	printf "Mayor porcentaje de agua: %s con %f \n", nombre_mayor_porcentaje, mayor_porcentaje
	printf "Menor porcentaje de agua: %s con %f \n", nombre_menor_porcentaje, menor_porcentaje


}