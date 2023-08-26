# Design-of-controllers
The codes in this repository demonstrate controllability, observability and PBH test, Full State Feedback (FSFB) controller design, implementation issues associated with FSFB, LQR controller design and Kalman Filter design using MATLAB and SIMULINK. The purpose of each code is described below:
1. Controllability_of_a_Linear_System.m and Controllability_test_simulation.slx
   * The code file and Simulink model demonstrate whether a particular (A, B) pair constitutes a controllable system or not.
3. PBH_Test.m
   * The code file shows the criteria needed to be satisfied to choose B so that a particular (A, B) pair constitutes a controllable system.
4. Full_State_Feedback_Control_Design.m
   * The code file demonstrates how to design a Full state feedback (FSFB) controller that will place the open loop eigenvalues to any arbitrarily closed-loop eigenvalues.
5. Implementation_Issues_with_a_FSFB.m and Full_state_feeback_control_model.slx
   * The code file and Simulink model demonstrate the issue of control saturation and the inability to measure states associated with the FSFB controller.
6. LQR_control.m and LQR_control_simulation.slx
   * The code file and Simulink model demonstrate an LQR design for a mass/damper system.
7. Observability_example.m and Observability_gramian_example.m
   * The first code file checks whether a particular (A,C) pair is observable or not. the second code file demonstrates the use of observability gramian.
8. Kalman_Filter_Design.m and Kalman_Filter_with_LQR.slx
   * The code file demonstrates the use of the Kalman filter for estimating states using the measurements available. The Kalman Filter does a good job of estimating the states even when there is noise and disturbances. The SIMULINK file combines LQR to observe the estimated state trajectory obtained using an LQR-based Full state feedback design.
