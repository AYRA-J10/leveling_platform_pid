# Leveling Platform — Full PID Control Simulation

MATLAB simulation of a PID-controlled two-axis leveling platform for defense and aerospace applications.

Built from first principles as part of a Mechatronics Engineering project at JEC, Kerala.

---

## System

**Plant:** Servo-driven leveling platform modeled as a second-order mechanical system

**Transfer function:** G(s) = 1 / (Js² + bs)

**Parameters:**
- J = 0.01 kg·m² (Moment of Inertia)
- b = 0.1 Ns/m (Viscous Damping)

---

## PID Controller

**Tuned gains:**
- Kp = 1.5
- Ki = 0.5
- Kd = 0.8
- Derivative filter N = 100

---

## Results

| Metric | Value |
|---|---|
| Rise Time | 22 ms |
| Overshoot | 1.46 % |
| Settling Time | 709 ms |
| Steady-State Error | 0.000000 |

![Platform Control Analysis](results.png)

---

## Features

- Wind disturbance rejection (0.5 rad gust at t = 1.5s)
- IMU sensor noise simulation (Gaussian, σ = 0.005)
- Derivative filter to prevent noise amplification
- 4-panel analysis dashboard
- Real performance metrics extracted via stepinfo()

---

## Relevance

Automatic leveling is a critical subsystem of every mobile launch system, shipborne weapon platform, and field-deployable antenna system. This simulation demonstrates the control architecture used in those systems.

---

## Tools

MATLAB R2025b · Control System Toolbox · Simulink
