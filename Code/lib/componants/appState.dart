import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/material.dart';

class AppState{
  static const String open = "Open";
  static const String InProgress = "In Progress";
  static const String Done = "Done";
  static const String High = "High";
  static const String Medium = "Medium";
  static const String Low = "low";

  static const List<String> Status = [open,InProgress,Done];
  static const List<String> Priority = [High,Medium,Low];
  static const List<Color> headerDividerColors = [AppColors.PrimaryText,AppColors.Error,AppColors.LightGreen];
  static const List<Color> priorityColors = [AppColors.Error,AppColors.Warning,AppColors.Primary];
}