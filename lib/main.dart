import 'package:flutter/material.dart';

import 'package:mana/theme/style.dart';
import 'package:mana/routes.dart';
import 'package:mana/bloc/bloc-prov-tree.dart';
import 'package:mana/bloc/bloc-prov.dart';
import 'package:mana/blocs/blocs.dart';
import 'blocs/blocs.dart';

void main() {
  runApp(ManaApp());
}

class ManaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: <BlocProvider>[
        BlocProvider<AuthBloc>(bloc: AuthBloc()),
        BlocProvider<PrefBloc>(bloc: PrefBloc()),
      ],
      child: MaterialApp(
        title: 'Prioritaria',
        theme: appTheme(),
        initialRoute: '/',
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
