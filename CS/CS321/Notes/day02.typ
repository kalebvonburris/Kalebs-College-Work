#set text(size: 16pt)

= Day 2 - 1/19/2024

== Computer Startup

A *bootstrap program* is loaded at power-up or reboot.

- Stored in ROM or EPROM; known as *firmware*.
- Initializes all aspects of the system.

== Interrupts

Interrupts are used to tell the OS to move on to another task and save the
address of the interrupted instruction.

Interrupts give control to the interrupt service through an *interrupt vector*
which contains the routines of the serivce.

*Traps* and *exceptions* are software-generated interrupts by errors or user
request.

=== Interrupt Handling

- The OS stores the state of registers and the program counter
- Determination of the type of interrupt
  - With *Polling* - the device is not known
  - With *Vectoring* (Vectored) - the device is known
- Code determines what happens for each interrupt
