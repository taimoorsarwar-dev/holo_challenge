import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BlocBase {
  final ReplaySubject<String> _titleStreamController = ReplaySubject<String>(
    maxSize: 1,
  );
  Stream<String> get titleStream => _titleStreamController.stream;

  final ReplaySubject<String> _subTitleStreamController = ReplaySubject<String>(
    maxSize: 1,
  );
  Stream<String> get subtitleStream => _subTitleStreamController.stream;

  @mustCallSuper
  void dispose() {
    _titleStreamController.close();
    _subTitleStreamController.close();
  }

  void setTitle({required String? title}) {
    if (_titleStreamController.isClosed == false) {
      _titleStreamController.sink.add(title!);
    }
  }

  void setSubTitle(String subTitle) {
    if (_subTitleStreamController.isClosed == false) {
      _subTitleStreamController.sink.add(subTitle);
    }
  }
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget? child;
  final T? bloc;

  const BlocProvider({super.key, required this.bloc, required this.child});

  static T of<T extends BlocBase>(BuildContext context) {
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.bloc!;
  }

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child!;

  @override
  void dispose() {
    widget.bloc!.dispose();
    super.dispose();
  }
}
