import 'package:demo2/Presentation/TaskScreen/TaskScreenWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class NavigationRoute {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return TaskScreenWidget();
        },
      ),
    ],
  );
}
