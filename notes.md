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

- Cada señal se gestiona con su signal handler.
	- Los signal handlers por defecto pueden cambiarse por los que yo escriba en mi programa.
		- Salvo los de KILL y STOP
	- Hay dos signal handlers predefinidos
		- SIG_DFL: Default
		- SIG_IGN: Ignore signal

- Las señales mandadas a una terminal se envía a todos los procesos lanzados desde ella.
	- Shell setea a SIG_IGN los handlers de todos los procesos que están en background
		- En nuestro programa lo tenemos que hacer nosotros?

## Instalar un handler

- se puede hacer con signal() y con sigaction()

### signal () vs sigaction()

#### signal

- int signal(SIGNAL, handler)
	- 
