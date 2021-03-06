library score_emitter;

import 'package:benchmark_harness/benchmark_harness.dart';

class ProperPrecisionScoreEmitter implements ScoreEmitter {
  const ProperPrecisionScoreEmitter();

  void emit(String testName, double value) {
    print('$testName (RunTime), ${value.toStringAsPrecision(4)}, µs');
  }
}

void recordTsvRecord(name, score, loopSize) {
  print(tsvLoop(name, score, loopSize));
}

String tsvLoop(name, score, loopSize) =>
  '${name} (RunTime in µs)\t'
  '${score.toStringAsPrecision(4)}\t'
  '${loopSize}\t'
  '${(score/loopSize).toStringAsPrecision(4)}';

recordTsvTotal(name, results, loopSize, numberOfRuns) {
  var averageScore = results.fold(0, (prev, element) => prev + element) /
    numberOfRuns;

  var tsv =
    '${name}\t'
    '${averageScore.toStringAsPrecision(4)}\t'
    '${loopSize}\t'
    '${(averageScore/loopSize).toStringAsPrecision(4)}';

  print(tsv);
}
