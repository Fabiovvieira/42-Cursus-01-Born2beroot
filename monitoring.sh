#!/bin/bash
arq=$(uname -a)
pproc=$(grep "physical id" /proc/cpuinfo | uniq | wc -l)
vproc=$(grep "processor" /proc/cpuinfo | wc -l)
mem=$(free --mega | grep "Mem" | awk '{printf("%d/%dMB (%.2f%%)",$3, $2, ($3/$2)*100)}')
disk=$(df -Bm | awk '{(NR > 1) ? (used += $3)(size += $2) : used size} END{printf("%d/%dMB (%d%%)", used, size, (used/size)*100)}')
cpuload=$(top -ibn1 | grep "%Cpu" | tr ',' ' ' | awk '{print $2+$4+$6+$10+$12+$14+$16"%"}')
lboot=$(who -b | awk '{print $3" "$4}')
lvm=$(lsblk | grep "lvm" | wc -l | awk 'NR == 1 {print ($0 > 0) ? "yes" : "no"}')
tcp=$(ss -ta | grep "ESTAB" | wc -l)
users=$(who | wc -l)
ip=$(hostname -I | awk '{print "IP "$0}')
mac=$(ip addr show | grep ether | awk 'NR == 1 {print "("$2")"}')
csudo=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)
wall "	#Arquitecture: $arq
	#CPU physical : $pproc
	#vCPU : $vproc
	#Memory Usage: $mem
	#Disk Usage: $disk
	#CPU load: $cpuload
	#Last boot: $lboot
	#LVM use: $lvm
	#Connections TCP : $tcp
	#User log: $users
	#Network: $ip $mac
	#Sudo : $csudo cmd
