#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void child_handler(int signum) {
	(void)signum;
    printf("Child.\n");
    exit(0);
}

void dad_handler(int signum) {
	(void)signum;
    printf("Dad.\n");
}

int main() {
    pid_t child_pid;


	while(1)
	{
	    //signal(SIGINT, SIG_IGN);
	    signal(SIGINT, dad_handler);
		// Create a new process
		child_pid = fork();
  		if (child_pid == 0) {
			printf("Child process with PID %d is running.\n", child_pid);
  		    // This code is executed by the child process
			signal(SIGINT, child_handler);
  		    while (1) {
				pause();
			}
		}
      	// This code is executed by the parent process
		printf("Child died\n");
		pause();
    }

    return 0;
}