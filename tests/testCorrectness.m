function tests = testCorrectness
%TESTCORRECTNESS Synthetic boundary checks; no fitted learner or dataset needed.
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
testCase.TestData.originalPath = path;
root = fileparts(fileparts(mfilename('fullpath')));
addpath(root, fullfile(root, 'tests', 'fixtures'), '-begin');
end

function teardownOnce(testCase)
path(testCase.TestData.originalPath);
end

function testNumericCategoryNames(testCase)
verifyEqual(testCase, numericLabels(categorical([0; 10; 20; 10])), [0; 10; 20; 10]);
verifyEqual(testCase, numericLabels({'-1'; '10'}), [-1; 10]);
end

function testRejectInvalidLabels(testCase)
verifyError(testCase, @() numericLabels({'person'}), 'Research:InvalidLabels');
verifyError(testCase, @() numericLabels([1; NaN]), 'Research:InvalidLabels');
end

function testVoteTiesAndNonconsecutiveLabels(testCase)
verifyEqual(testCase, votePredictions([10 20; -1 -1; 0 10]), [10; -1; 0]);
end

function testRejectEmptyAndFailedVotes(testCase)
verifyError(testCase, @() votePredictions(zeros(3, 0)), 'Research:InvalidPredictions');
verifyError(testCase, @() votePredictions([1 NaN]), 'Research:InvalidPredictions');
end

function testAlreadyBalancedClustersAreRetained(testCase)
data = [0 0; 1 10];
clusters{1}.idxs = [true; true];
clusters{1}.centroids = .5;
actual = balanceClusters(clusters, data);
verifyEqual(testCase, actual{1}, data);
end

function testBalancingUsesEuclideanDistanceWithoutDuplicates(testCase)
data = [0 0; 1 0; .1 10; 100 10; 101 10];
clusters{1}.idxs = [true; true; false; false; false];
clusters{1}.centroids = .5;
actual = balanceClusters(clusters, data);
verifyEqual(testCase, actual{1}, data(1:4, :));
end
