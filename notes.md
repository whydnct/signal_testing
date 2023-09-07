# Inspeccionar procesos de un proceso

https://www.baeldung.com/linux/checking-signals-process-listens
- ps
	- muestra los procesos abiertos en una terminal
	- -e -> procesos de otros usuarios, controlados o no por una terminal
	- -a -> procesos tuyos y de otros usuarios, que estén controlados por una terminal
	- -j -> información de user, pid, ppid, fid ...
	- -l -> información de uid, pid, ppid, flags ...
	- -o -> información de las keywords que pases después: pid, sig, cmd
	- -p -> selecciona por pid: -p pid

# Overview of signals
https://www.cs.princeton.edu/courses/archive/fall05/cos217/lectures/23signals.pdf

