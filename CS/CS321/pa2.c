#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
void sigHandler (int);
int main() {
  signal(SIGINT, sigHandler);
  printf("Waiting for signal... Press Ctrl+C to send an interrupt.\n");
  pause();
  return 0;
}

void sigHandler (int sigNum) {
  printf("\nReceived an interrupt signal through Ctrl-C.\n");
  printf("Going to sleep.\n Notice the process is not exiting immediately.\n");
  
  

  sleep(1);
  printf("Now the process will terminate with the exit system call.\n");
  exit(0);
}
