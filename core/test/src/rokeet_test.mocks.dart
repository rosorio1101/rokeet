// Mocks generated by Mockito 5.0.7 from annotations
// in rokeet_ui/test/src/rokeet_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;
import 'dart:ui' as _i7;

import 'package:flutter/src/foundation/diagnostics.dart' as _i4;
import 'package:flutter/src/widgets/framework.dart' as _i3;
import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart' as _i1;
import 'package:rokeet_ui/src/actions/action.dart' as _i10;
import 'package:rokeet_ui/src/actions/actions.performer.dart' as _i11;
import 'package:rokeet_ui/src/model.dart' as _i5;
import 'package:rokeet_ui/src/network/rokeet_api.dart' as _i8;
import 'package:rokeet_ui/src/pages/page.dart' as _i6;
import 'package:rokeet_ui/src/rokeet.dart' as _i2;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeRokeet extends _i1.Fake implements _i2.Rokeet {}

class _FakeBuildContext extends _i1.Fake implements _i3.BuildContext {}

class _FakeWidget extends _i1.Fake implements _i3.Widget {
  @override
  String toString({_i4.DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class _FakeDiagnosticsNode extends _i1.Fake implements _i4.DiagnosticsNode {
  @override
  String toString({_i4.TextTreeConfiguration? parentConfiguration, _i4.DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class _FakeAppConfig extends _i1.Fake implements _i5.AppConfig {}

class _FakeRStep extends _i1.Fake implements _i5.RStep {}

class _FakeInheritedWidget extends _i1.Fake implements _i3.InheritedWidget {
  @override
  String toString({_i4.DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

/// A class which mocks [RState].
///
/// See the documentation for Mockito's code generation for more information.
class MockRState<T extends _i6.AbstractRokeetPage, D> extends _i1.Mock
    implements _i6.RState<T, D> {
  MockRState() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set data(D? _data) => super.noSuchMethod(Invocation.setter(#data, _data),
      returnValueForMissingStub: null);
  @override
  _i2.Rokeet get rokeet => (super.noSuchMethod(Invocation.getter(#rokeet),
      returnValue: _FakeRokeet()) as _i2.Rokeet);
  @override
  bool get isLoading =>
      (super.noSuchMethod(Invocation.getter(#isLoading), returnValue: false)
          as bool);
  @override
  T get widget =>
      (super.noSuchMethod(Invocation.getter(#widget), returnValue: null) as T);
  @override
  _i3.BuildContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
          returnValue: _FakeBuildContext()) as _i3.BuildContext);
  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);
  @override
  _i3.Widget getLoadingWidget() =>
      (super.noSuchMethod(Invocation.method(#getLoadingWidget, []),
          returnValue: _FakeWidget()) as _i3.Widget);
  @override
  void onDataLoaded(D? data) =>
      super.noSuchMethod(Invocation.method(#onDataLoaded, [data]),
          returnValueForMissingStub: null);
  @override
  void initState() => super.noSuchMethod(Invocation.method(#initState, []),
      returnValueForMissingStub: null);
  @override
  void didUpdateWidget(T? oldWidget) =>
      super.noSuchMethod(Invocation.method(#didUpdateWidget, [oldWidget]),
          returnValueForMissingStub: null);
  @override
  void reassemble() => super.noSuchMethod(Invocation.method(#reassemble, []),
      returnValueForMissingStub: null);
  @override
  void setState(_i7.VoidCallback? fn) =>
      super.noSuchMethod(Invocation.method(#setState, [fn]),
          returnValueForMissingStub: null);
  @override
  void deactivate() => super.noSuchMethod(Invocation.method(#deactivate, []),
      returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  _i3.Widget build(_i3.BuildContext? context) =>
      (super.noSuchMethod(Invocation.method(#build, [context]),
          returnValue: _FakeWidget()) as _i3.Widget);
  @override
  void didChangeDependencies() =>
      super.noSuchMethod(Invocation.method(#didChangeDependencies, []),
          returnValueForMissingStub: null);
  @override
  void debugFillProperties(_i4.DiagnosticPropertiesBuilder? properties) =>
      super.noSuchMethod(Invocation.method(#debugFillProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  String toStringShort() => (super
          .noSuchMethod(Invocation.method(#toStringShort, []), returnValue: '')
      as String);
  @override
  String toString({_i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info}) =>
      (super.noSuchMethod(
          Invocation.method(#toString, [], {#minLevel: minLevel}),
          returnValue: '') as String);
  @override
  _i4.DiagnosticsNode toDiagnosticsNode(
          {String? name, _i4.DiagnosticsTreeStyle? style}) =>
      (super.noSuchMethod(
          Invocation.method(
              #toDiagnosticsNode, [], {#name: name, #style: style}),
          returnValue: _FakeDiagnosticsNode()) as _i4.DiagnosticsNode);
}

/// A class which mocks [RokeetApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockRokeetApi extends _i1.Mock implements _i8.RokeetApi {
  MockRokeetApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isLoading =>
      (super.noSuchMethod(Invocation.getter(#isLoading), returnValue: false)
          as bool);
  @override
  set isLoading(bool? _isLoading) =>
      super.noSuchMethod(Invocation.setter(#isLoading, _isLoading),
          returnValueForMissingStub: null);
  @override
  _i9.Future<_i5.AppConfig> getApp(String? clientId, String? clientSecret) =>
      (super.noSuchMethod(Invocation.method(#getApp, [clientId, clientSecret]),
              returnValue: Future<_i5.AppConfig>.value(_FakeAppConfig()))
          as _i9.Future<_i5.AppConfig>);
  @override
  _i9.Future<_i5.RStep> getStep(String? stepId) =>
      (super.noSuchMethod(Invocation.method(#getStep, [stepId]),
              returnValue: Future<_i5.RStep>.value(_FakeRStep()))
          as _i9.Future<_i5.RStep>);
}

/// A class which mocks [RActionPerformer].
///
/// See the documentation for Mockito's code generation for more information.
class MockRActionPerformer<A extends _i10.RAction<dynamic>> extends _i1.Mock
    implements _i11.RActionPerformer<A> {
  MockRActionPerformer() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void performAction(_i2.Rokeet? rokeet, A? action) =>
      super.noSuchMethod(Invocation.method(#performAction, [rokeet, action]),
          returnValueForMissingStub: null);
}

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuildContext extends _i1.Mock implements _i3.BuildContext {
  MockBuildContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Widget get widget => (super.noSuchMethod(Invocation.getter(#widget),
      returnValue: _FakeWidget()) as _i3.Widget);
  @override
  bool get debugDoingBuild => (super
          .noSuchMethod(Invocation.getter(#debugDoingBuild), returnValue: false)
      as bool);
  @override
  _i3.InheritedWidget dependOnInheritedElement(_i3.InheritedElement? ancestor,
          {Object? aspect}) =>
      (super.noSuchMethod(
          Invocation.method(
              #dependOnInheritedElement, [ancestor], {#aspect: aspect}),
          returnValue: _FakeInheritedWidget()) as _i3.InheritedWidget);
  @override
  void visitAncestorElements(bool Function(_i3.Element)? visitor) =>
      super.noSuchMethod(Invocation.method(#visitAncestorElements, [visitor]),
          returnValueForMissingStub: null);
  @override
  void visitChildElements(_i3.ElementVisitor? visitor) =>
      super.noSuchMethod(Invocation.method(#visitChildElements, [visitor]),
          returnValueForMissingStub: null);
  @override
  _i4.DiagnosticsNode describeElement(String? name,
          {_i4.DiagnosticsTreeStyle? style =
              _i4.DiagnosticsTreeStyle.errorProperty}) =>
      (super.noSuchMethod(
          Invocation.method(#describeElement, [name], {#style: style}),
          returnValue: _FakeDiagnosticsNode()) as _i4.DiagnosticsNode);
  @override
  _i4.DiagnosticsNode describeWidget(String? name,
          {_i4.DiagnosticsTreeStyle? style =
              _i4.DiagnosticsTreeStyle.errorProperty}) =>
      (super.noSuchMethod(
          Invocation.method(#describeWidget, [name], {#style: style}),
          returnValue: _FakeDiagnosticsNode()) as _i4.DiagnosticsNode);
  @override
  List<_i4.DiagnosticsNode> describeMissingAncestor(
          {Type? expectedAncestorType}) =>
      (super.noSuchMethod(
          Invocation.method(#describeMissingAncestor, [],
              {#expectedAncestorType: expectedAncestorType}),
          returnValue: <_i4.DiagnosticsNode>[]) as List<_i4.DiagnosticsNode>);
  @override
  _i4.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(Invocation.method(#describeOwnershipChain, [name]),
          returnValue: _FakeDiagnosticsNode()) as _i4.DiagnosticsNode);
}
