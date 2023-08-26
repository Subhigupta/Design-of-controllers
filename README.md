# Design-of-controllers
The codes in this repository demonstrate controllability, observability and PBH test, Full State Feedback (FSFB) controller design, implementation issues associated with FSFB, LQR controller design and Kalman Filter design using MATLAB and SIMULINK. The purpose of each code is described below:
1. Controllability_of_a_Linear_System and Controllability_test_simulation
   * The code file and Simulink model demonstrates whether a particular (A, B) pair constitutes a controllable system or not.
3. PBH_Test
   * The code file shows the criteria needed to be satisfied to choose B so that a particular (A, B) pair constitute a controllable system.
4. Full_State_Feedback_Control_Design
   * The code file demonstrates how to design a Full state feedback controller that will place the open loop eigen values to any arbitrary closed loop eigen values.
5. Implementation_Issues_with_a_FSFB and Full_state_feeback_control_model
   * The code file and Simulink model demonstrate the issue of control saturation and the inability to measure states associated with FSFB controller.
6. LQR_control and LQR_control_simulation
   * The code file and Simulink model does a LQR design for a mass/damper system.
