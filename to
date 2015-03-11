#!/bin/bash

declare -A work_host_array
declare -A rd_host_array

work_host_array=(
	[lab1]="172.16.7.201" 
	[lab2]="172.16.7.206"
	[lab3]="172.16.7.202" 
	[lab4]="172.16.7.203" 
	[lab5]="172.16.2.15" 
	[lab6]="172.16.10.162" 
	[dev]="10.6.4.118"
)

rd_host_array=(
	["newlab"]="172.16.0.78"
)

work_host=${work_host_array[$1]}
rd_host=${rd_host_array[$1]}

if [[ -n $work_host ]] ; then
	ssh -t chaoguo@osys11.meilishuo.com ssh -t work@$work_host
elif [[ -n $rd_host ]] ; then
	ssh -t chaoguo@osys11.meilishuo.com ssh -t rd@$rd_host
else
	ssh -t chaoguo@osys11.meilishuo.com ssh -t rd@$1
fi
