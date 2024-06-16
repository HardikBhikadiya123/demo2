import 'package:demo2/Data/Model/taskModel.dart';
import 'package:demo2/Data/Repositories/TaskRepo.dart';
import 'package:demo2/Data/data_sources/TaskHiveDataSource.dart';
import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Domain/UseCase/add_task.dart';
import 'package:demo2/Domain/UseCase/delete_task.dart';
import 'package:demo2/Domain/UseCase/get_tasks.dart';
import 'package:demo2/Domain/UseCase/update_tasks.dart';
import 'package:demo2/Presentation/AddTask/AddTaskWidget.dart';
import 'package:demo2/Presentation/AddTask/add_task_bloc.dart';
import 'package:demo2/Presentation/TaskScreen/Task_Bloc.dart';
import 'package:demo2/Presentation/TaskScreen/taskBox.dart';
import 'package:demo2/UnAvailableDevice/unavailableDeviceWidget.dart';
import 'package:demo2/componants/appState.dart';
import 'package:demo2/componants/commanWidget.dart';
import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskScreenWidget extends StatefulWidget {
  const TaskScreenWidget({super.key});

  @override
  State<TaskScreenWidget> createState() => _TaskScreenWidgetState();
}

class _TaskScreenWidgetState extends State<TaskScreenWidget> {
  TextEditingController textController = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();
  CommanWidget commanWidget = CommanWidget();
  Box<Map<dynamic, dynamic>>? hiverecords;
  bool dataload = false;
  List allTasks = [];

  @override
  void dispose() {
    textController.dispose();
    textFieldFocusNode.dispose();
    super.dispose();
  }

  getHivedata() async {
    try {
      hiverecords = await Hive.openBox('tasks');
      hiverecords?.watch().listen((event) {
        _loadTasks();
      });
    } catch (error) {
      print("Error ---->$error");
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getHivedata();
  }

  _loadTasks() async {
    if (hiverecords != null) {
      allTasks = hiverecords!.values.map((e) => TaskModel.fromJson(e)).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width > 880 && hiverecords != null
          ? BlocProvider<TaskBloc>(
              create: (BuildContext context) => TaskBloc(
                getTasks: GetTasks(
                    TaskRepositoryImpl(TaskHiveDataSource(Hive.box('tasks')))),
              )..add(LoadTasks()),
              child: BlocListener<TaskBloc, TaskState>(
                  listener: (context, state) {
                    if (state is TaskLoading) {
                      dataload = true;
                    } else {
                      dataload = false;
                      state.props.length != 0
                          ? allTasks = state.props as List
                          : null;
                    }
                    setState(() {

                    });
                  },
                  child: dataload
                      ? Center(
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                  color: AppColors.white)))
                      : Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 14, 20, 14),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 20, 0),
                                                  child: Text(
                                                    'Tasks',
                                                    style: TextStyle(
                                                      fontFamily: 'Readex Pro',
                                                      color: AppColors
                                                          .SecondaryText,
                                                      fontSize: 19,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0, 0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child: BlocProvider<
                                                              AddTaskBloc>(
                                                            create: (context) =>
                                                                AddTaskBloc(
                                                              addTask: AddTask(
                                                                  TaskRepositoryImpl(
                                                                      TaskHiveDataSource(
                                                                          hiverecords!))),
                                                              deleteTask: DeleteTask(
                                                                  TaskRepositoryImpl(
                                                                      TaskHiveDataSource(
                                                                          hiverecords!))),
                                                              updateTask: UpdateTask(
                                                                  TaskRepositoryImpl(
                                                                      TaskHiveDataSource(
                                                                          hiverecords!))),
                                                            ),
                                                            child:
                                                                AddTaskWidget(
                                                              isitForEdit:
                                                                  false,
                                                              lastTaskId:
                                                                  allTasks.length !=
                                                                          0
                                                                      ? allTasks
                                                                          .last
                                                                          .id
                                                                      : 0,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                      padding:
                                                          const MaterialStatePropertyAll(
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24,
                                                                      20,
                                                                      24,
                                                                      20)),
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              AppColors.white),
                                                      elevation:
                                                          const MaterialStatePropertyAll(
                                                              0),
                                                      shape: MaterialStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              side:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              )))),
                                                  child: Text('Add New Task+',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color:
                                                              AppColors.Primary,
                                                          fontSize: 18,
                                                          letterSpacing: 0)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 0, 8, 0),
                                                child: SizedBox(
                                                  width: 200,
                                                  child: TextFormField(
                                                    controller: textController,
                                                    focusNode:
                                                        textFieldFocusNode,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      hintText: 'Search',
                                                      hintStyle: TextStyle(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: AppColors
                                                            .SecondaryText,
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                      ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      prefixIcon: Icon(
                                                        Icons.search,
                                                        color: AppColors
                                                            .SecondaryText,
                                                        size: 28,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'Readex Pro',
                                                      color: AppColors
                                                          .SecondaryText,
                                                      fontSize: 18,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.filter_list,
                                                    color:
                                                        AppColors.SecondaryText,
                                                    size: 35,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            15, 0, 25, 0),
                                                    child: Text(
                                                      'Filter',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: AppColors
                                                            .SecondaryText,
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  commanWidget.divided(
                                      color: AppColors.SecondaryText,
                                      thikmess: 3),
                                  if (allTasks.length != 0 &&
                                      allTasks.first.runtimeType == TaskModel)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: List.generate(
                                                AppState.Status.length,
                                                (index) => TaskBox(
                                                      dividerColor: AppState
                                                              .headerDividerColors[
                                                          index],
                                                      tital: AppState
                                                          .Status[index],
                                                      taskList: allTasks
                                                          .where((element) =>
                                                              (element.status ==
                                                                  AppState.Status[
                                                                      index]))
                                                          .toList() as List<Task>,
                                                      hiverecords: hiverecords,
                                                    ))),
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "No Data Available, Please add some data here.",
                                          style: TextStyle(
                                              color: AppColors.PrimaryText,
                                              fontSize: 15),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )),
            )
          : UnAvailableDeviceWidget(),
    );
  }
}
