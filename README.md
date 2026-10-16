# Diversity-Based Ensemble Classifier Selection

Historical MATLAB research code associated with diversity-based ensemble classification.

## Research reference and attribution

M. Z. Jan and B. Verma, "A Novel Diversity Measure and Classifier Selection Approach for Generating Ensemble Classifiers," IEEE Access, vol. 7, pp. 156360–156373, 2019.

DOI: [10.1109/ACCESS.2019.2949059](https://doi.org/10.1109/ACCESS.2019.2949059)

Please cite the relevant publication and retain source author notices. Existing dataset and third-party terms still apply; this cleanup does not grant a new licence.

## Data and environment

Extract `EXTRACT TO ROOT.zip` into the repository root and inspect its contents. Ensure `P-Data/<name>.mat` exists for every name in `Problem`. Each file must supply `X` (samples × features) and `y` (a label column).

**MATLAB dependencies:** Statistics and Machine Learning Toolbox; Deep Learning Toolbox. Optional optimisation examples may need additional files/toolboxes.

No exact original MATLAB/toolbox version is recorded. Use MATLAB rather than assuming GNU Octave compatibility for the learner APIs.

## Start here

1. Open this repository as the MATLAB current folder. Use a separate session/path for each research repository: helper filenames overlap across projects.
2. Supply or extract the data described above. Check feature/label row counts and class labels.
3. Edit `Problem` in `mainProgram.m` (or `dataSetNames.m` where used), and start with one dataset and one repeat.
4. Run the synthetic utility checks, then inspect `mainProgram.m` before starting the full experiment:

```matlab
results = runtests('tests');
assertSuccess(results);
rng(42, 'twister');
mainProgram;
```

The seed is a starting point for recording runs; nested seed resets, parallel workers and toolbox versions can still affect reproducibility. `runMultiple.m` performs 50 full driver repetitions and is not the quick-start command.

## Workflow and output

`mainProgram.m` selects datasets and calls a ten-fold workflow. The active `runTraining.m` uses `getCNN.m` on balanced clusters; the configured list of six learner families is not used by that active path. `fusion.m` combines predictions; `saveResults.m` exports aggregate accuracy and deviation.

`saveResults.m` appends rows to `results.csv` in the current folder and writes the header only when creating the file. Driver-level CSV writes are sequential to avoid concurrent append races. Archive old output before a new configuration; rows do not contain a complete environment/configuration record. Committed CSV files are historical outputs, not freshly validated benchmarks.

## Review notes and reproducibility limits

The repository title reflects the associated paper; the checked-in active driver is a CNN clustering variant, not proof that it reproduces every paper experiment. `Main.m` (capital M) is a separately attributed binary-PSO example and is not the ensemble entry point. Verify categorical/numeric prediction handling in `fusion.m` and the balancing distance convention before a scientific run; those methods have been preserved.

The cleanup aligns function/file names, restores visible warnings, makes CSV handles close on errors, and tests constant-feature normalisation plus CSV append behaviour. MATLAB experiments and the new utility tests have **not** been executed in the cleanup environment, which has no MATLAB installation. Static parsing is not a reproduction of the paper.

[Profile and project directory](https://github.com/zohaibjan)
