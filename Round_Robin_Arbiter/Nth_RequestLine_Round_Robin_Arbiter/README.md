# Nth Modified Round Robin Arbiter (MRRA)

### Overview

The Nth Modified Round Robin Arbiter (MRRA) is designed to manage access to a shared resource by rotating through multiple request lines in a round-robin fashion. It ensures fair and prioritized resource allocation by giving active devices a chance to access the shared resource based on a rotating sequence, using a ring counter mechanism.
This arbiter is suitable for systems with multiple devices that require fair access to resources while respecting active requests.

### Features

- Fair Resource Allocation: Ensures devices receive equal access based on their turn in the round-robin sequence.
- Prioritization: Actively prioritizes devices making requests, ensuring no device is starved.
- Ring Counter Logic: The arbiter rotates through requests using a ring counter, simplifying the decision process.
- Flexible: Works with any number of devices (N), making it adaptable to various system requirements.

### Inputs

- clk: Clock signal, used to synchronize the arbiter’s operation.
- rst: Reset signal that resets the state of the arbiter.
- req: Request signals, with each bit representing a device’s request for resource access.
  

### Outputs
- grant: Grant signals, where each bit indicates which device has been granted access.

### Working Principle

The arbiter checks for active requests from devices and grants access in a round-robin manner. The process is managed by the ring counter, which rotates to select the next active device based on its request. If no device is requesting access, the arbiter keeps rotating until one is active.

- On reset (rst), the first device gets access.
- The arbiter continues to grant access in a cyclic fashion to active devices.


### Use Cases

- Multiplexing: Ideal for systems where multiple devices need periodic access to a shared resource.
- Network Protocols: Ensures fair access among nodes or devices in communication systems.
- Embedded Systems: Useful for systems with multiple sensors or actuators that need synchronized access to a shared processing unit.