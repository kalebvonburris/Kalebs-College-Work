// Lab 2 - Process and Interprocess Communication
// Kaleb Burris
// 2025-02-12
// This program forks a child process that sends random signals to the parent process.
// The parent process handles the signals and prints a message to the console.
// The parent process also handles SIGINT to exit cleanly.

use std::ffi::c_void;

use libc::{c_int, sighandler_t, signal};

static mut CHILD_PID: i32 = 0;

fn main() {
    unsafe {
        // fork!
        let pid = libc::fork();
        if pid == 0 {            
            // Child process
            let parent_pid = libc::getppid();

            loop {
                // Send random signal
                if libc::rand() % 2 == 0 {
                    libc::kill(parent_pid, libc::SIGUSR1);
                } else {
                    libc::kill(parent_pid, libc::SIGUSR2);
                }

                // Sleep for 1-5 seconds
                let sleep_time = (libc::rand() % 5) + 1;
                libc::sleep(sleep_time as u32);
            }
        } else {
            // Parent process

            // Set Child_PID to the child process ID
            CHILD_PID = pid;

            // Setup signal handlers for parent process
            // We have to do some very cursed casts here to turn it into a function pointer for C
            let handler_ptr = signal_handler as extern "C" fn(c_int) as *mut c_void as sighandler_t;

            signal(libc::SIGUSR1, handler_ptr);

            signal(libc::SIGUSR2, handler_ptr);

            signal(libc::SIGINT, handler_ptr);

            // Wait for child to exit
            while libc::wait(&mut (pid as i32)) > 0 {}
        }
    }
}

extern "C" fn signal_handler(signum: c_int) {
    match signum {
        libc::SIGUSR1 => println!("Received SIGUSR1"),
        libc::SIGUSR2 => println!("Received SIGUSR2"),
        libc::SIGINT => {
            println!("Received SIGINT");
            // Wait for the child to exit
            unsafe { 
                libc::kill(CHILD_PID, libc::SIGKILL);
                libc::wait(&mut (CHILD_PID as i32));
            };

            // We use the Rust exit here as it will call destructors and drop the child process gracefully
            std::process::exit(0);
        }
        _ => eprintln!("Received unknown signal {signum}"),
    }
}
