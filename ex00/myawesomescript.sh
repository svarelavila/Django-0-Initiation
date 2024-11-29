#!/bin/bash

# Verifica si se ha proporcionado un argumento (URL)
if [ -z "$1" ]; then
  echo "Usage: $0 <bit.ly URL>"
  exit 1
fi

# Obtener la URL final después de las redirecciones
final_url=$(curl -Ls -o /dev/null -w %{url_effective} "$1")

# Comprobación de error en curl
if [ $? -ne 0 ]; then
  echo "Error: Unable to resolve URL."
  exit 2
fi

# Mostrar la URL final
echo "$final_url"
