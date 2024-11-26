#!/bin/sh

# Verificar si se proporcionó un argumento
if [ -z "$1" ]; then
  echo "Usage: $0 <bit.ly URL>"
  exit 1
fi

# Verificar si la URL empieza con http:// o https://
if ! echo "$1" | grep -qE '^https?://'; then
  echo "Error: Invalid URL format."
  exit 1
fi

# Resolver la URL final y obtener el código HTTP
final_url=$(curl -Ls -o /dev/null -w "%{url_effective} %{http_code}" "$1")

# Separar la URL final y el código HTTP usando cut
url=$(echo "$final_url" | cut -d ' ' -f 1)
http_code=$(echo "$final_url" | cut -d ' ' -f 2)

# Comprobar si el código HTTP es de éxito (2xx)
if [ "$http_code" -ge 200 ] && [ "$http_code" -lt 300 ]; then
  echo "Success: $url"
else
  echo "Error: HTTP $http_code - $url"
  exit 1
fi
