#!/bin/bash
pid=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem,%cpu | head -n 4 | tail -1 | awk '{print $1}')
mem=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem,%cpu | head -n 4 | tail -1 | awk '{print $5}')
cpu=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem,%cpu | head -n 4 | tail -1 | awk '{print $6}')
port=$(netstat -ntlp | grep $pid | awk '{print $4}' | awk -F: '{print $2}')
echo -e "ProcessID"     "MemUtil"       "CPUUtil"	"PortUsed"
echo -e "$pid"	'\t'	"$mem"	'\t'	"$cpu"'\t'          "$port"
