#!/bin/bash
#
randomstring() {
	cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w $@ | head -n 1
}
