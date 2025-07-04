Intrinsic Reaction Coordinate - IRC Module
================================================
The IRC module is used for generating reaction paths.

**Common Keywords**

:guilabel:`ircpts` Parameter Type: Integer
------------------------------------------------
 * Default: 50
 * Options: Positive integers

Sets the maximum number of points to examine along the reaction path (in each direction).

:guilabel:`ircdir` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: 1, -1

Sets the direction of the reaction:
* 1: Forward direction
* -1: Reverse direction
* 0: Simulate both directions

:guilabel:`ircalpha` Parameter Type: Floating-point
------------------------------------------------
 * Default: 0.1
 * Options: Non-negative floating-point numbers

Scales the initial displacement. The initial displacement is related to the Hessian at the transition state. Adjusts the step size for IRC calculations by modifying this parameter.