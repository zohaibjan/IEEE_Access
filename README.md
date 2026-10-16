# Diversity-Based Ensemble Classifier Selection

MATLAB research code for investigating diversity measures and selecting base classifiers for an ensemble.

## Paper

M. Z. Jan and B. Verma, "A Novel Diversity Measure and Classifier Selection Approach for Generating Ensemble Classifiers," IEEE Access, vol. 7, pp. 156360–156373, 2019.

DOI: [10.1109/ACCESS.2019.2949059](https://doi.org/10.1109/ACCESS.2019.2949059)

Please cite this paper when using the research code.

## Getting started

1. Inspect and extract the supplied `EXTRACT TO ROOT.zip` archive into the repository directory.
2. Open `mainProgram.m` in MATLAB and review the selected datasets and classifier parameters.
3. Check that dataset folders expected by the code are available.
4. Run `mainProgram`.

The ensemble experiment entry point is `mainProgram.m`. The separate `Main.m` contains an optimisation example with its own original author attribution.

## Implementation

- `generateClusters.m` and `balanceClusters.m`: data partitioning and balancing.
- `runTraining.m`: ensemble experiment workflow.
- `fusion.m`: prediction combination.
- `saveResults.m`: output generation.

The configuration includes multiple classifier families and ten-fold evaluation. The entry point uses `parfor`; check the required MATLAB toolboxes for your environment.

## Status and attribution

Historical research implementation. Dependency versions are not pinned, and results have not been revalidated as part of the documentation cleanup. Preserve third-party attribution in source files and check the applicable dataset and code terms before redistribution.

[Profile and project directory](https://github.com/zohaibjan)
