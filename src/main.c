#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void child_sigint_handler(int signum) {
	(void)signum;
    printf("Child process received SIGINT signal.\n");
    printf("Wanna kill it? Uncomment exit(0)...\n");
    //exit(0);
}

int main() {
    pid_t child_pid;

    // Create a new process
    child_pid = fork();

	signal(SIGINT, SIG_IGN);
	while(1)
	{
  		if (child_pid == 0) {
  		    // This code is executed by the child process
			signal(SIGINT, child_sigint_handler);
  		    while (1) {
				pause();
  		        // Infinite loop
			}
		}
      	// This code is executed by the parent process
      	printf("Child process with PID %d is running.\n", child_pid);
      	// Parent process can continue to do other tasks
		wait(NULL);
		printf("Child died\n");
		pause();
    }

    return 0;
}