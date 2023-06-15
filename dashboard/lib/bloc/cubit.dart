import 'package:dashboard/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/bloc/states.dart';

import '../components/constants.dart';

class DashboardManager extends Cubit<DashboardState> {
  DashboardManager() : super(InitialState());

  DashboardManager get(context) => BlocProvider.of<DashboardManager>(context);

  bool isExpanded = false;
  void openMenu() {
    isExpanded = !isExpanded;
    print(isExpanded);
    emit(ChangeMenuState(isExpanded: isExpanded));
  }

  int selectedIndex = 0;
  void changeMenu(int index) {
    selectedIndex = index;
    emit(ChangeMenuState());
  }

  double pageWidth = double.infinity;
  double changePageWidth(context) {
    (isExpanded) ? pageWidth = width(context, .78) : pageWidth = width(context, .9);
    print('haha $pageWidth');
    emit(ChangePageWidth());
    return pageWidth;
  }
}
