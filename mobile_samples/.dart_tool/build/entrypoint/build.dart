// ignore_for_file: directives_ordering

import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:copyable/src/generator/builder.dart' as _i2;
import 'package:json_serializable/builder.dart' as _i3;
import 'package:source_gen/builder.dart' as _i4;
import 'package:build_config/build_config.dart' as _i5;
import 'dart:isolate' as _i6;
import 'package:build_runner/build_runner.dart' as _i7;
import 'dart:io' as _i8;

final _builders = <_i1.BuilderApplication>[
  _i1.apply('copyable:copyable', [_i2.localCopyableBuilder],
      _i1.toDependentsOf('copyable'),
      hideOutput: true, appliesBuilders: ['source_gen:combining_builder']),
  _i1.apply('copyable:copier', [_i2.localCopierBuilder],
      _i1.toDependentsOf('copyable'),
      hideOutput: true, appliesBuilders: ['source_gen:combining_builder']),
  _i1.apply('json_serializable:json_serializable', [_i3.jsonSerializable],
      _i1.toDependentsOf('json_serializable'),
      hideOutput: true, appliesBuilders: ['source_gen:combining_builder']),
  _i1.apply('source_gen:combining_builder', [_i4.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: ['source_gen:part_cleanup']),
  _i1.apply('copyable:foreignCopyableLib', [_i2.foreignCopyableLibraryBuilder],
      _i1.toDependentsOf('copyable'),
      hideOutput: false),
  _i1.apply('copyable:foreignCopierLib', [_i2.foreignCopierLibraryBuilder],
      _i1.toDependentsOf('copyable'),
      hideOutput: false),
  _i1.applyPostProcess('source_gen:part_cleanup', _i4.partCleanup,
      defaultGenerateFor: const _i5.InputSet())
];
main(List<String> args, [_i6.SendPort sendPort]) async {
  var result = await _i7.run(args, _builders);
  sendPort?.send(result);
  _i8.exitCode = result;
}
