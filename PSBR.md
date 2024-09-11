## PRBS-15
# introduction 
PRBS-15 (Pseudo-Random Binary Sequence) is a sequence of binary values generated using a 15-bit Linear Feedback Shift Register (LFSR). It has a maximum length of 32,767 bits before repeating, making it ideal for testing communication systems and data integrity. PRBS-15 simulates random data patterns but is deterministic, allowing reproducibility with a known seed. It's commonly used for stress testing in hardware, error detection analysis, and performance validation of digital systems. The sequence is generated using XOR feedback logic based on specific register taps.

### PSBR Block Interface

![Screenshot 2024-09-09 132350](https://i.imgur.com/benfhDe.png)

## FSM of PSBR

* state IDLE : when reset asserted 
* state OUT_BYTE : satate to output the 4 Bytes in 4 clock cycles
* state Updata_PRBS : state to make Psudeo random algorism and ensure pattern repeated n times 

![graphviz](https://i.imgur.com/M3YUdRQ.png)

## Test PSBR Block 
![Screenshot 2024-09-09 134108](https://i.imgur.com/snfYWNg.png)

- as shown on figure the first test case repeat 4 times with pattern A5A6A7A8 and PSBR Block out the 4 bytes in 16 clock cycle as each byte on one clock cycle.
* the second test repeat 8 times the pattern and the test case passed also

## Edge Detector 
An edge detector is a digital circuit or algorithm used to detect changes or transitions in a signal, typically from low to high (rising edge) or high to low (falling edge). It is commonly used in synchronous systems to identify events or trigger actions on specific signal changes. Edge detectors are essential in controlling state transitions, capturing events, and synchronizing asynchronous signals with a clock. They can be implemented using simple logic gates or flip-flops, depending on the design requirements. Edge detection is crucial in various applications like interrupts, timers, and communication protocols.

## Edge counter FSM
![graphviz](https://i.imgur.com/8kWoICb.png) 

## Test Edge Detector

![Screenshot 2024-09-09 135109](https://i.imgur.com/fjgSVV3.png)

* first test case input correct pattern then the detected flag will be raised this test is passed.
* second test case input incorrect pattern then the detected flag will not be raised this test is passed

## SYSTEM TOP 
![Screenshot 2024-09-09 135333](https://i.imgur.com/wkczs6U.png)

## Test System
* integrate system done well with right functionality.


![Screenshot 2024-09-09 135454](https://i.imgur.com/GMnDvSL.png)![Screenshot 2024-09-09 135534](https://i.imgur.com/QvuBGNI.png)







