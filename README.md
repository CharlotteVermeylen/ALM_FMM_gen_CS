# ALM_FMM_gen_CS
In this code we implement an extension of the augmented Lagrangian (AL) method proposed in:

Vermeylen, C., Van Barel, M. Stability improvements for fast matrix multiplication. Numer Algor (2024). https://doi.org/10.1007/s11075-024-01806-y,

for the fast matrix multiplication problem (FMM) to include the generalized cyclic symmetric (CS) structure for polyadic decompositions (PDs) of matrix multiplication tensors (MMTs) proposed in:

Vermeylen, C., Van Barel, M. Generalized cyclic symmetric decompositions for the matrix multiplication tensor. https://doi.org/10.48550/arXiv.2310.02794,

to reduce the number of variables in the optimization problem and improve the convergence. The experiments that are presented in the manuscript are saved in the folder ‘results’ for different problem parameters.

The implementation of the AL method is given in the folder ‘ALM’, together with the most important auxiliary functions such as an implementation of a Levenberg Marquardt (LM) method for the minimisation to x in ‘LM_ALM.m’.

Other, more general auxiliary functions are given in the folder ‘functions’.

The folder ‘scripts’ contains some example scripts, e.g., with ‘test_ALM.m’ you are able to regenerate the results from the manuscript. The scripts ‘test_ranks_J.m’ and ‘plot_results.m’ are used to analyze and visualize the results.
