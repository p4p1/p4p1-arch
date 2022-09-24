#!/usr/bin/env bash

main() {
	CPU_PROG=$(top -b -n1 | grep "CPU" -A 2 | tail -n1 | awk -F' ' '{print $12 ":("$1")"}')
	CPU_USAGE=$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]
	echo "$CPU_PROG $CPU_USAGE%"
}

main
