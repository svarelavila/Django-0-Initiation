#!/bin/bash

# Check if an argument (URL) has been provided
if [ -z "$1" ]; then
  echo "Usage: $0 <bit.ly URL>"
  exit 1
fi

# Get the final URL after redirects
final_url=$(curl -Ls -o /dev/null -w %{url_effective} "$1")

# Error checking in curl
if [ $? -ne 0 ]; then
  echo "Error: Unable to resolve URL."
  exit 2
fi

# Show final URL
echo "$final_url"