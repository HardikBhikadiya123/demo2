import 'dart:async';

import 'package:demo2/Data/Repositories/TaskRepo.dart';
import 'package:demo2/Data/data_sources/TaskHiveDataSource.dart';
import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Domain/UseCase/add_task.dart';
import 'package:demo2/Domain/UseCase/delete_task.dart';
import 'package:demo2/Domain/UseCase/update_tasks.dart';
import 'package:demo2/Presentation/AddTask/AddTaskWidget.dart';
import 'package:demo2/Presentation/AddTask/add_task_bloc.dart';
import 'package:demo2/Presentation/AddTask/add_task_event.dart';
import 'package:demo2/Presentation/AddTask/add_task_state.dart';
import 'package:demo2/Presentation/ManageTask/ManageTaskWidget.dart';
import 'package:demo2/Presentation/TaskItem/circulureProgressIndicatorWidget.dart';
import 'package:demo2/componants/appState.dart';
import 'package:demo2/componants/commanWidget.dart';
import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskItemWidget extends StatefulWidget {
  final String ItemName;
  final Task task;
  final Box<Map<dynamic, dynamic>>? hiverecords;

  const TaskItemWidget({
    super.key,
    required this.ItemName,
    required this.task,
    required this.hiverecords,
  });

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  DateFormat dateFormat = DateFormat("MMM dd, yyyy");

  updateStatus() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment:
              AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
          child: BlocProvider<AddTaskBloc>(
            create: (context) => AddTaskBloc(
              addTask: AddTask(
                  TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
              deleteTask: DeleteTask(
                  TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
              updateTask: UpdateTask(
                  TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
            ),
            child: BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (context, state) {
                return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.9,
                    child: ManageTaskWidget(task: widget.task));
              },
            ),
          ),
        );
      },
    ).then((value) => setState(() {}));
  }

  EditTask() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment:
              AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
          child: BlocProvider<AddTaskBloc>(
            create: (context) => AddTaskBloc(
              addTask: AddTask(
                  TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
              deleteTask: DeleteTask(
                  TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
              updateTask: UpdateTask(
                  TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
            ),
            child: BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (context, state) {
                return AddTaskWidget(
                  isitForEdit: true,
                  task: widget.task,
                );
              },
            ),
          ),
        );
      },
    );
  }

  CirnfitmationpopUp() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider<AddTaskBloc>(
          create: (context) => AddTaskBloc(
            addTask: AddTask(
                TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
            deleteTask: DeleteTask(
                TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
            updateTask: UpdateTask(
                TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
          ),
          child: BlocBuilder<AddTaskBloc, AddTaskState>(
            builder: (context, state) => AlertDialog(
              alignment: Alignment.center,
              backgroundColor: AppColors.white,
              shadowColor: AppColors.white,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        height: 40,
                        margin: EdgeInsetsDirectional.fromSTEB(0, 15, 15, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0)),
                              elevation: MaterialStatePropertyAll(3),
                              backgroundColor:
                                  MaterialStatePropertyAll(AppColors.white),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.Black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ))),
                          child: Text('Close',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: AppColors.Black,
                                letterSpacing: 0,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        height: 40,
                        margin: EdgeInsetsDirectional.fromSTEB(0, 15, 15, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              context
                                  .read<AddTaskBloc>()
                                  .add(DeleteExistingTask(widget.task.id));
                              Navigator.of(context).pop(true);
                            } catch (error) {
                              print("Err0r ----->${error}");
                            }
                          },
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0)),
                              elevation: MaterialStatePropertyAll(3),
                              backgroundColor:
                                  MaterialStatePropertyAll(AppColors.white),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.Error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ))),
                          child: Text('Delete',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: AppColors.Error,
                                letterSpacing: 0,
                              )),
                        ),
                      ),
                    )
                  ],
                )
              ],
              title: Text("Delete Record",
                  style: TextStyle(
                      color: AppColors.Error,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              content: Text(
                  "Are you sure!, You want to delete this ${widget.task.title} Task?",
                  style: TextStyle(
                      color: AppColors.PrimaryBackground, fontSize: 14)),
            ),
          ),
        );
      },
    );
  }

  initalizeBlocProvider({required Widget widgetChild}) {
    return BlocProvider<AddTaskBloc>(
      create: (context) => AddTaskBloc(
        addTask: AddTask(
            TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
        deleteTask: DeleteTask(
            TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
        updateTask: UpdateTask(
            TaskRepositoryImpl(TaskHiveDataSource(widget.hiverecords!))),
      ),
      child: BlocBuilder<AddTaskBloc, AddTaskState>(
        builder: (context, state) => widgetChild,
      ),
    );
  }

  String takeDiferencebetween() {
    var differ = widget.task.endTime.difference(widget.task.startTime);
    var duration = differ.abs();
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.ItemName == AppState.InProgress &&
            widget.task.endTime.millisecond > DateTime.now().microsecond) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.PrimaryBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://picsum.photos/seed/129/600',
                              width: 300,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time - ${takeDiferencebetween()}h',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: AppColors.SecondaryText,
                                  fontSize: 13,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                'Task Completed - ${widget.task.completeTask.toString().replaceAll("[", "").replaceAll("]", "")}',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: AppColors.SecondaryText,
                                  fontSize: 13,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        circulurProgressIndicatorWidget(
                            tital: "Progress",
                            color: AppColors.Primary,
                            perValue: (widget.task.completeTask.length /
                                    widget.task.tasks.length)
                                .round()),
                        circulurProgressIndicatorWidget(
                            tital: "Projects",
                            color: AppColors.LightGreen,
                            perValue: 10),
                        circulurProgressIndicatorWidget(
                            tital: "On time\nSubmission",
                            color: AppColors.Warning,
                            perValue: 100),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.12,
                          child: ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.SecondaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              )),
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColors.PrimaryBackground),
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero),
                              elevation: MaterialStatePropertyAll(3),
                            ),
                            child: Text('See More',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: AppColors.SecondaryText,
                                  fontSize: 14.0,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.13,
                          child: ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.SecondaryText,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                )),
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero),
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColors.PrimaryBackground),
                                elevation: MaterialStatePropertyAll(3)),
                            child: Text('View Profile',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: AppColors.SecondaryText,
                                  fontSize: 14.0,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          int priorityIndex = AppState.Priority.indexOf(widget.task.priority);
          return Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 150,
            ),
            decoration: BoxDecoration(
              color: AppColors.PrimaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                    widget.ItemName == AppState.InProgress ? 0.0 : 5.0),
                bottomRight: Radius.circular(
                    widget.ItemName == AppState.InProgress ? 0.0 : 5.0),
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.task.title,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: AppColors.SecondaryText,
                              fontSize: 15,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: AppColors.white,
                          elevation: 3,
                          iconColor: AppColors.SecondaryText,
                          onSelected: (value) {
                            switch (value) {
                              case 1:
                                EditTask();
                                break;
                              case 2:
                                updateStatus();
                                break;
                              case 3:
                                CirnfitmationpopUp();
                                break;
                            }
                          },
                          icon: Icon(
                            Icons.keyboard_control,
                            color: AppColors.SecondaryText,
                            size: 20,
                          ),
                          itemBuilder: (context) => [
                            widget.ItemName != AppState.InProgress
                                ? PopupMenuItem(
                                    value: 1,
                                    child: Text("Edit",
                                        style: TextStyle(
                                            color: AppColors.PrimaryBackground,
                                            fontSize: 14)),
                                  )
                                : PopupMenuItem(
                                    value: 2,
                                    child: Text("Update status",
                                        style: TextStyle(
                                            color: AppColors.PrimaryBackground,
                                            fontSize: 14)),
                                  ),
                            PopupMenuItem(
                              value: 3,
                              child: Text("Delete",
                                  style: TextStyle(
                                      color: AppColors.PrimaryBackground,
                                      fontSize: 14)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Priority - ',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: AppColors.SecondaryText,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.task.priority,
                                  style: TextStyle(
                                    color:
                                        AppState.priorityColors[priorityIndex],
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: AppColors.Error,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1, -1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1562307534-a03738d2a81a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHxsb2dvfGVufDB8fHx8MTcxODI1MzMyOXww&ixlib=rb-4.0.3&q=80&w=1080',
                              width: 50,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (widget.ItemName != AppState.InProgress) {
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                        children: List.generate(
                                            4,
                                            (index) => Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          index != 0
                                                              ? (index * 20)
                                                              : 0,
                                                          0,
                                                          0,
                                                          0),
                                                  child: ClipOval(
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.03,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.03,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors.white,
                                                            width: 2.5,
                                                          ),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxwZXJzb258ZW58MHx8fHwxNzE4MjU5NzAzfDA&ixlib=rb-4.0.3&q=80&w=1080"))),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                    ),
                                                  ),
                                                ))),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                      child: SizedBox(
                                        height: 25,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print(
                                                'WorkFlow Button pressed ...');
                                          },
                                          style: ButtonStyle(
                                              padding:
                                                  const MaterialStatePropertyAll(
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15, 0, 15, 0),
                                              ),
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      AppColors.Primary),
                                              elevation:
                                                  const MaterialStatePropertyAll(
                                                      0),
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ))),
                                          child: const Text("Workflow",
                                              style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 15),
                                        child: Wrap(
                                          spacing: 0,
                                          runSpacing: 0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children: [
                                            if (widget.ItemName ==
                                                AppState.Done)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 5, 0),
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  color:
                                                      AppColors.SecondaryText,
                                                  size: 20.0,
                                                ),
                                              ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: Icon(
                                                CupertinoIcons.clock,
                                                color: widget.ItemName ==
                                                        AppState.Done
                                                    ? AppColors.LightGreen
                                                    : AppColors.SecondaryText,
                                                size: 20.0,
                                              ),
                                            ),
                                            Text(
                                              '00:00:00 h',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: widget.ItemName ==
                                                        AppState.Done
                                                    ? AppColors.LightGreen
                                                    : AppColors.SecondaryText,
                                                fontSize: 20.0,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Created - ${dateFormat.format(widget.task.startTime)}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: AppColors.SecondaryText,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        'Due - ${dateFormat.format(widget.task.endTime)}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: AppColors.SecondaryText,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        CupertinoIcons.clock,
                                        color: AppColors.white,
                                        size: 20,
                                      ),
                                    ),
                                    manageTimmer(
                                        task: widget.task,
                                        parentAction: () => setState(() {})),
                                  ],
                                ),
                              ),
                              Text(
                                'Company - Caterpillar',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: AppColors.white,
                                  fontSize: 14,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 15, 0, 0),
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'Created - ${dateFormat.format(widget.task.startTime)}',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: AppColors.SecondaryText,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )),
                                      SelectionArea(
                                          child: Text(
                                        'Due - ${dateFormat.format(widget.task.endTime)}',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: AppColors.SecondaryText,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class manageTimmer extends StatefulWidget {
  final Task task;
  final Function() parentAction;

  const manageTimmer(
      {super.key, required this.task, required this.parentAction});

  @override
  State<manageTimmer> createState() => _manageTimmerState();
}

class _manageTimmerState extends State<manageTimmer> {
  late Timer timer;
  String diff = "";

  takeDiferencebetween() {
    managetimer();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      managetimer();

    });
    if (DateTime.now().microsecond > widget.task.endTime.microsecond) {
      widget.parentAction();
      timer.cancel();
    }
  }

  managetimer(){
    var differ = DateTime.now().difference(widget.task.startTime);
    var duration = differ.abs();
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    diff = '${hours}:'
        '${minutes}:'
        '${seconds}';
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    takeDiferencebetween();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      diff,
      style: TextStyle(
        fontFamily: 'Readex Pro',
        color: AppColors.white,
        fontSize: 20,
        letterSpacing: 0.5,
      ),
    );
  }
}
