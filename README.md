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

The active path is a CNN clustering variant; the paper title alone does not establish exact reproduction. CNN categorical predictions now convert by their numeric names before voting. Cluster balancing retains already balanced subsets, selects by feature-space Euclidean distance and excludes rows already present. These changes replace the historical signed-distance and dropped-cluster behavior and require fresh results. `Main.m` is a separately attributed binary-PSO example, not the ensemble entry point.

## Runtime follow-up — October 2026

getCNN accepts an optional epoch budget for smoke tests; the default research training budget remains unchanged.

## Correctness review — October 2026

This pass fixes implementation defects; it does not validate the associated research results. Changes can alter model pools, predictions and measured scores. Re-run the experiments before comparing corrected code with historical CSVs or published results.

- Label conversion uses numeric category names, not categorical indices.
- Voting rejects empty/nonfinite inputs; a prediction failure is reported rather than counted as a fabricated class-one vote.
- CNN output categories retain their numeric label names, including zero and nonconsecutive labels.
- Synthetic checks cover normalization, CSV append behavior and the new prediction/selection boundaries. Additional cluster checks run where applicable.

See [the code review](docs/code-review.md) for repository-specific changes, tests and remaining limitations.

**Validation:** 13 regression/smoke tests passed in MATLAB R2024b on Linux through [GitHub Actions](https://github.com/zohaibjan/IEEE_Access/actions/workflows/matlab-tests.yml). Tests include real toolbox execution on synthetic data. Full research datasets and published accuracy results have not been reproduced. See [validation evidence and limits](docs/validation.md).

[Profile and project directory](https://github.com/zohaibjan)
