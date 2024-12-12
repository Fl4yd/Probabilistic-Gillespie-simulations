# Chemical Reaction Simulation

## Overview
This project simulates a two-step chemical reaction system using both deterministic ODE modeling and stochastic Gillespie simulations. The reactions are defined as follows:

1. A + B → C
2. B + C → D

The simulation aims to compare deterministic and stochastic approaches to understand system behavior, especially in small populations.

---

## Project Structure

- **`reaction.m`**: MATLAB code implementing both deterministic and stochastic simulations of the chemical reaction system.
- **`report.pdf`**: A detailed report explaining the mathematical formulations, methods, results, and conclusions of the project.

---

## Features

1. **Deterministic ODE Modeling**:
   - Captures the expected behavior of the reaction system.
   - Solves ODEs numerically to generate smooth trajectories.

2. **Stochastic Gillespie Simulations**:
   - Incorporates randomness to simulate discrete molecular interactions.
   - Highlights variability in reaction trajectories due to stochastic effects.

3. **Comparison of Methods**:
   - Visual and statistical comparison of deterministic and stochastic results.
   - Histograms to analyze end-state distributions of molecules.

4. **Scalability Analysis**:
   - Examines the impact of increasing molecule populations on system behavior.
   - Shows convergence of stochastic simulations to deterministic predictions as population size grows.

---

## Installation and Setup

1. Clone the repository or download the project files.
2. Ensure MATLAB is installed on your system.
3. Open `reaction.m` in MATLAB.
4. Run the script to generate results and plots.

---

## Key Parameters

- **Reaction Rates**:
  - k1 = 0.0013
  - k2 = 0.01

- **Initial Conditions**:
  - A = 100, B = 100, C = 0, D = 0

- **Simulation Settings**:
  - Time: 0 to 35 units
  - Time Step: 0.01 units
  - Number of Simulations: 100

---

## Results

- **Temporal Evolution**:
  - Deterministic trajectories provide smooth solutions.
  - Stochastic trajectories exhibit variability, particularly during early reactions.

- **End-State Distributions**:
  - Species A and D show low variability.
  - Species C demonstrate significant stochastic effects.
  - Species B converges to zero

- **Scalability**:
  - Stochastic variability diminishes as molecule populations increase, aligning closely with deterministic predictions.

---

## References

1. [Gillespie, D. T.](https://en.wikipedia.org/wiki/Gillespie_algorithm): Algorithm for stochastic chemical kinetics.
2. MATLAB Documentation: Numerical ODE solvers and Poisson random number generation.

---

## Authors

- **Jere Arokivi**
- **Matti Aalto**
- **Max Wesamaa**

December 2024
