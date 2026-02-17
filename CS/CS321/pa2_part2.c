#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <time.h>
#include <sys/wait.h>

int CHILD_PID = 0;

void sigHandler (int);
int main() {
  int pid = fork();

  if (pid == 0) {
    // This is the child process.
    int parent_id = getppid();
    printf("Child process started with PID %d. Parent PID is %d.\n", getpid(), parent_id);
    
    while(1) {
      // 1 - 5 second wait
      int ttw = rand() % 5 + 1;

      printf("Child PID %d sleeping for %d seconds.\n", getpid(), ttw);

      sleep(ttw);

      int sig_to_send = (rand() % 2) ? SIGUSR1 : SIGUSR2;

      kill(parent_id, sig_to_send);
    }
  } else {
    // This is the parent process.
    CHILD_PID = pid;

    printf("Parent process started with PID %d. Child PID is %d.\n", getpid(), CHILD_PID);

    // Install signal handler for SIGUSR1 and SIGUSR2.
    signal(SIGUSR1, sigHandler);
    signal(SIGUSR2, sigHandler);
    // Install graceful shutdown handler for SIGINT.
    signal(SIGINT, sigHandler);
    
    while (1) {
      int status;
      waitpid(CHILD_PID, &status, 0);
    }
  }
}

void sigHandler (int sigNum) {
    switch (sigNum) {
        case SIGUSR1:
            printf("Received SIGUSR1 signal from child PID %d.\n", CHILD_PID);
            break;
        case SIGUSR2:
            printf("Received SIGUSR2 signal from child PID %d.\n", CHILD_PID);
            break;
        case SIGINT:
            printf("Received an interrupt signal (SIGINT) from the user. Killing child.\n");
            kill(CHILD_PID, SIGKILL);
            
            int child_status;

            while (waitpid(CHILD_PID, &child_status, 0) == -1) {
                // Wait for the child process to terminate.
                printf("Waiting for child PID %d to terminate...\n", CHILD_PID);
            }
            
            exit(0);
            break;
        default:
            printf("Received an unexpected signal: %d\n", sigNum);
    }
}
