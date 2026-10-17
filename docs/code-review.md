# Code review and validation scope

The active path is a CNN clustering variant; the paper title alone does not establish exact reproduction. CNN categorical predictions now convert by their numeric names before voting. Cluster balancing retains already balanced subsets, selects by feature-space Euclidean distance and excludes rows already present. These changes replace the historical signed-distance and dropped-cluster behavior and require fresh results. `Main.m` is a separately attributed binary-PSO example, not the ensemble entry point.

## Changed behavior and acceptance

The fixes preserve original source attribution and the documented experiment entry points. They change previously erroneous edge cases and may change reported results. Stored outputs were not rewritten or relabelled as new results.

Run in a clean MATLAB session with only this repository on the path:

```matlab
results = runtests('tests');
assertSuccess(results);
```

The test fixtures are synthetic. `FixedClassifier`, where supplied, implements `predict` without fitting a model and is on the path only for the test session. Majority ties choose the smallest numeric label. Empty or invalid votes fail explicitly. ANN vocabularies are learned from training labels, not held-out labels. PSO thresholds retain the repository's setting, with one shared nonempty mask policy for objective scoring and final return. Random selection, where used, has at most pool-size times elimination-budget attempts.

## Executed MATLAB validation

Actual CNN training/prediction with zero and nonconsecutive numeric labels, cluster balancing, voting, source loading and CSV/normalization utilities.

getCNN accepts an optional epoch budget for smoke tests; the default research training budget remains unchanged.

See [validation.md](validation.md) for the exact run, release and boundaries.

## Remaining validation

- Compatibility beyond the tested MATLAB R2024b/toolbox release.
- Full training runs with the documented datasets, preserving training/validation/test separation.
- Numerical quality, random seeds, paper-method agreement, runtime and memory consumption.
- Optional historical optimizer/diversity/alternate-driver files are not a validated library.

The regression/smoke suite passed in MATLAB R2024b using MathWorks GitHub Actions. Synthetic fixtures check implementation behavior; full research experiments, historical accuracy and performance benchmarks have not been reproduced.
