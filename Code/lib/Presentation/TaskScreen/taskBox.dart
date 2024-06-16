import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Presentation/TaskItem/TaskItemWidget.dart';
import 'package:demo2/componants/appState.dart';
import 'package:demo2/componants/commanWidget.dart';
import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TaskBox extends StatefulWidget {
  final String tital;
  final Color dividerColor;
  final List<Task> taskList;
  final Box<Map<dynamic, dynamic>>? hiverecords;
  const TaskBox({super.key, required this.tital, required this.dividerColor, required this.taskList, required this.hiverecords});

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  CommanWidget commanWidget = CommanWidget();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsetsDirectional.fromSTEB(
            0, 15, 15, 15),
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.SecondaryBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment:
                AlignmentDirectional(-1, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional
                      .fromSTEB(0, 0, 0, 10),
                  child: Text(
                    widget.tital,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      color:
                      AppColors.PrimaryText,
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
              commanWidget.divided(color:  widget.dividerColor, thikmess: 3),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional
                      .fromSTEB(0, 15, 0, 0),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection:
                    Axis.vertical,
                    itemCount: widget.taskList.length,
                    separatorBuilder: (_,
                        __) =>
                    widget.tital == AppState.InProgress ? CommanWidget().divided(color: AppColors.Divied, thikmess: 2) : SizedBox(height: 15),
                    itemBuilder:
                        (context, Index) {
                      return TaskItemWidget(ItemName: widget.tital, task: widget.taskList[Index],hiverecords: widget.hiverecords);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
