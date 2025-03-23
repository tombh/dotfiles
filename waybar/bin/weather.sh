#!/bin/bash

# temperature="$(
# 	curl --silent \
# 		-A "api.met.no@tombh.co.uk" \
# 		"https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=-34.6&lon=-58.38" \
# 		| jq '.properties.timeseries[0].data.instant.details.air_temperature'
# )"
#
# echo -n "{\"text\": \" 🌡️$temperature°C\"}"

lookup_latitude="-34.6"
lookup_longitude="-58.38"
domain="tombh.co.uk"
request_by="Tom BH api.met.no@$domain"

api_endpoint="https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=$lookup_latitude&lon=$lookup_longitude"
state_dir="$(dirname $0)/state"
mkdir -p "$state_dir"

if [ -f "$state_dir/header.txt" ]; then
	last_modified=$(grep -i '^Last-Modified:' "$state_dir/header.txt" | sed 's/Last-Modified: //I')
fi

if [ -n "$last_modified" ]; then
	#"Sending conditional GET with If-Modified-Since: $last_modified"

	http_code=$(curl -s \
		-A "$request_by" \
		-w "%{http_code}" \
		-H "If-Modified-Since: $last_modified" \
		-D "$state_dir/header.txt" \
		-o "$state_dir/cache.json" \
		"$api_endpoint")
else
	# "No Last-Modified info found; performing a normal GET..."
	curl -s \
		-A "$request_by" \
		-D "$state_dir/header.txt" \
		-o "$state_dir/cache.json" \
		"$api_endpoint"
fi

declare -A units
while IFS= read -r line; do
	key="${line%%=*}"
	value="${line#*=}"
	units["$key"]="$value"
done < <(
	jq -r '.properties.meta.units
          |to_entries[]
          |"\(.key)=\(.value)"' "$state_dir/cache.json"
)

declare -A details
while IFS= read -r line; do
	key="${line%%=*}"
	value="${line#*=}"
	details["$key"]="$value"
done < <(
	jq -r '.properties.timeseries[0].data.instant.details
          |to_entries[]
          |"\(.key)=\(.value)"' "$state_dir/cache.json"
)

echo -n "{\"text\": \" 🌡️${details[air_temperature]}°C\", \"tooltip\":\"rel. humidity: ${details[relative_humidity]}${units[relative_humidity]}\\n pressure: ${details[air_pressure_at_sea_level]} ${units[air_pressure_at_sea_level]}\"}"
