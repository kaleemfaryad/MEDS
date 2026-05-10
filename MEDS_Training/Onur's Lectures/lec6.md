# Digital Design and Computer Architecture

## L6: Timing & Verification II

### Circuits delay

Outputs are delayed from inputs, like tranistors have finite amount of time to switch
Capacitens and resistance in a circuit, rising and falling inputs cause delay
Different inputs have different delays

### Delay types

Contamination delay: clock edge start changings
Propagation delay: clock edge finihes changings

### Calculating Long/Short Paths

its not easy because not all input transitions affect the output
And circuit are not all built equally -> different instances of same gate have different delays,
Temperature/Voltage affect Circuit speeds

### Combinational Timing

Delays change with circuit design and operating conditions

### Glitches:

One input transition causes multipe output transitions
we can fix the glitches with the help of K-maps , but we don't always care about the glitches, we only care about long-term steady output,
we use safely ignore glitches

### Timing Constraints

Setup Time: time before the clock edge that data must be stable
Hold Time: time after clock edge that data must be stable
Aperture time: time around clock edge that data must be stable
Time around = setup time + hold time

### Metastability

when flipflop output stuck somewhere between 1 and 0 , its called metastability
output eventually settles non-deterministically
Critical path: longest path

### Clock Skew

Clock Skew is the time difference between two clock edges because clocks have delay too
it increases the both setup time and hold time, increasing sequencing overhead
designers must keep skew to minimum

### Testing

it is most time consuming design stage it includes functional correctness of all logic paths,timing,power
low-level(circuits) simulation is much slower than high-level(HDL,C) simulation
soo to reduce the testing time we check only functionality at a high-level and time,power at low-level

### Testing tools

Logic Synthesis tools-> guarantee equivalence of high-level logic and synthesized circuit-level description
Timing verification tools ->check all circuit timings
Design rule checks-> ensures that physical circuits are buildable

### Verifications

Functional Verifications: check correctness of the design

### Testbench

it is a module created specifically to test a design
test design is called Device Under Test(DUT)
testbench provides inputs/test patterns to the DUT
testbench checks outputs of the DUT against hand-crafted values , a golden design that is design to be bug-free

### Simple Testbench

easy to design , easily test few,specific inputs
but not scalable to many test cases , output must be checked manuaaly outside of the simulation

### Self-checking testbench

easy to design, easy to test a few specific inputs, simulator will print whenever an error occurs
but not scalable to millions of test cases,easy to make an error in handcoded values

### Self-checking testbench with test vectors

easy to design, easy to test a few specific inputs, simulator will print whenever an error occurs, and No need to change hardcodedvalues for different tests
but may be error-prone depending on the test vectors, more scaleable but still limited by reading a file

### Golden Models

A golden Model represents the ideal circuit behavior, must be developed and might be difficult to write
can be done in C,Perl,Python or even in verilogs

### Automatic testbench

The DUT output is compared against the golden model
challenges: need to generate inputs to the designs
Output checking fully automated, could even compare timing using a golden timing model
highly scaleable to as much simulation time as is feasible
but creating a correct golden model may be very difficult,coming up with good testing inputs may be difficult
