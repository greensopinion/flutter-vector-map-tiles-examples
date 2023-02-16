import 'package:flutter/material.dart';

class Loadable<T> extends StatefulWidget {
  final Future<T> Function() loader;
  final Widget Function(BuildContext, T) builder;

  const Loadable({super.key, required this.loader, required this.builder});

  @override
  State<StatefulWidget> createState() => _Loadable<T>();
}

class _Loadable<T> extends State<Loadable<T>> {
  T? state;
  String? loadError;

  @override
  void initState() {
    super.initState();
    widget
        .loader()
        .then((value) => setState(() {
              state = value;
            }))
        .onError((error, stackTrace) => {
              setState(() {
                loadError = error?.toString();
                // ignore: avoid_print
                print(loadError);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    final loaded = state;
    if (loaded != null) {
      return widget.builder(context, loaded);
    }
    final errorMessage = loadError;
    if (errorMessage != null) {
      return Expanded(child: Text(errorMessage));
    }
    return Column(children: const [Center(child: CircularProgressIndicator())]);
  }
}
