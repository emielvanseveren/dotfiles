#!/bin/zsh

function dive {
	docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock:ro \
		wagoodman/dive "$@"
}
