Built a complete PID control simulation of a leveling platform in MATLAB tonight.

Not a tutorial. From first principles.

Plant modeled from the actual physics — moment of inertia, viscous damping, transfer function. Then tuned a PID controller until:

• Rise time: 22ms
• Overshoot: 1.46%
• Steady-state error: 0

Also simulated a wind disturbance hitting the platform at t=1.5s and watched the controller reject it automatically.

This is the math behind every mobile launch system, shipborne antenna, and field weapon platform that needs to stay level.

Sem 3. Still learning. But building.

GitHub: github.com/AYRA-J10/leveling-platform-pid

#ControlSystems #PID #MATLAB #Mechatronics #Defense #Embedded
