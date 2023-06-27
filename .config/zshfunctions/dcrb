#!/bin/zsh

function dcrb {
	if [ -z "$1" ]; then
		compose_file="docker-compose.yml"
	else
		compose_file=$1
	fi
	docker-compose -f "$compose_file" down --remove-orphans && docker-compose -f "$compose_file" up -d --build --force-recreate && docker-compose -f "$compose_file" logs -f
}
