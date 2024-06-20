# ENAE743: Nonlinear Analysis and Control Final Project
This is a final project completed for Nonlinear Control at the University of Maryland

### Overview
The goal of this work was to apply principles of nonlinear control to a novel research project. Here, I applied sliding mode control techniques to control the nonlinear behavior of a flapping micro-aerial vehicle (MAV). The ultimate goal was attitude stabilization under the presence of unknown, external disturbances. This work may find application in the inner loop of a positioning contoller. All work was conducted in Simulink to solve the ODE's with MATLAB helper scripts for plotting and analysis

### Methodology
The governing dynamics were first adopted from existing literature and formulated for this problem. Then, the sliding surface was defined, where the dynamics were naturally partitioned into the euler angles and rates. The sliding mode controller was defined and, along with a quadratic lyapunov function, used to demonstrate exponential convergence under no disturbance cases and at least GAS convergence under time-varying disturbance cases. Finally, an observer was adopted from the literature to recreate the disturbances necessary for the controller. 

![Example_MAV](https://github.com/JMocklerUMD/ENAE743-Final-Project/assets/150191399/2c60cb00-cc6b-4436-97c6-e2bc9c1af0bd)

*Fig. 1 - Example Micro-Aerial Vehicle in flight. The typical propulsion and control mechanisms are in the wing flapping behavior*

### Results
The controller was first tested for it's ability to exponentially converge non-zero initial conditions back to the origin. The first figure below shows the controller driving the system to the stable origin exponetially fast. 
![initial_disturb](https://github.com/JMocklerUMD/ENAE743-Final-Project/assets/150191399/c742028d-a1ac-4e10-a472-538ecfdb630f)
*Fig. 2 - The sliding-mode controller drives the system from non-zero initial conditions to zero exponentially fast.*

Then, an unknown step disturbance is injected in the system. Two parallel processes begin working on the system: the observer begins recreating the disturbance and the controller begins making use of this disturbance. Then, at the 10-sec mark, a time-verying disturbance with noise is injected. With the step response, a lyapunov analysis suggests GUAS convergence to the origin, while under time-varying disturbances, only stability close to the origin is gaurenteed. The two figures below show the observer recreation of the disturbance and the response.

![dist_recreation](https://github.com/JMocklerUMD/ENAE743-Final-Project/assets/150191399/acb19bc5-a6c6-49f8-8db3-f002301de095)
*Fig. 3 - Disturbance recreation of the step and time-varying disturbances*

![dist_response](https://github.com/JMocklerUMD/ENAE743-Final-Project/assets/150191399/6836066d-4a6c-4f7b-a878-187748326e2c)
*Fig. 4 - Disturbance response of the MAV*

The nonlinear analysis is in good agreement wtih the simulation results. Finally, I considered how the sliding mode is operating on the system. If a phase plot of the two dynamic variables is created, one should see the controller driving the dynamics clockwise along the plot until reaching the sliding surface, where the controller will drive the system to the origin. A similar figure was created here (using L1 norms to accomodate the 6-dof) and show agreement with the fundamental operation of ths sliding mode controller.
![sliding_surf](https://github.com/JMocklerUMD/ENAE743-Final-Project/assets/150191399/115a4cac-6118-4439-8179-ee0d1497c2bc)
*Fig. 5 - Sliding mode phase plot showing how the controller drives the system towards the sliding surface*
