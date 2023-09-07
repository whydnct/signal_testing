#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void child_killer(int signum, siginfo_t *info, void *context)
{
	(void)signum;
	(void)info;
	(void)context;
	write(1, "\x1b[31mI killed a child.\n\x1b[0m", 27);
	exit(0);
}

void child_carer(int signum, siginfo_t *info, void *context) {
	(void)signum;
	(void)info;
	(void)context;
	write(1, "\x1b[31mI let the child live.\n\x1b[0m", 31);
}

void dad_handler(int signum, siginfo_t *info, void *context) {
	(void)signum;
	(void)info;
	(void)context;
	write(1, "\x1b[31mI'm Dad.\n\x1b[0m", 18);
}

int main(int argc, char **argv) {
	(void)argv;
	pid_t child_pid;
	struct sigaction sa;


	sa.sa_flags = SA_RESTART;
	while(1)
	{
		if (argc > 1)
			sa.sa_sigaction = child_killer;
		else
			sa.sa_sigaction = child_carer;
		sigaction(SIGINT, &sa, NULL);
		child_pid = fork();
  		if (child_pid == 0) {
			write(1, "A child was born.\n", 18);
			sigaction(SIGINT, &sa, NULL);
  			// This code is executed by the child process
  			while (1) {
				pause();
				write(1, "Child is still alive.\n", 22);
			}
		}
		wait((int *)&child_pid);
	  	// This code is executed by the parent process
		write(1, "Another round?\n", 15);
		// sa.sa_sigaction = dad_handler;
		// sigaction(SIGINT, &sa, NULL);
		pause();
	}

	return 0;
}