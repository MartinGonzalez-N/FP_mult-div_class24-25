# Archivo que contiene la lista de nombres (uno por línea)
ARCHIVO_NOMBRES="TEST_NAMES.txt"

# Leer cada nombre del archivo y ejecutar el comando
while IFS= read -r NOMBRE
do
  for i in {1..20}
  do
    echo "Ejecutando prueba para: $NOMBRE"
    make sim_cov testname=$NOMBRE num_seed=$i;
  done
done < "$ARCHIVO_NOMBRES"
