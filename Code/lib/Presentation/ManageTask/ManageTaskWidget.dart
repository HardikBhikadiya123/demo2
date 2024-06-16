import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Presentation/AddTask/add_task_bloc.dart';
import 'package:demo2/Presentation/AddTask/add_task_event.dart';
import 'package:demo2/Presentation/AddTask/add_task_state.dart';
import 'package:demo2/componants/InputTextFieldWidget.dart';
import 'package:demo2/componants/appState.dart';
import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageTaskWidget extends StatefulWidget {
  final Task task;

  const ManageTaskWidget({super.key, required this.task});

  @override
  State<ManageTaskWidget> createState() => _ManageTaskWidgetState();
}

class _ManageTaskWidgetState extends State<ManageTaskWidget> {
  TextEditingController titalTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  FocusNode titalFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  String status = AppState.Status.first;
  List<String> completedTaskList = [];

  @override
  void dispose() {
    super.dispose();
    titalTextController.dispose();
    descriptionTextController.dispose();
    titalFocusNode.dispose();
    descriptionFocusNode.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titalTextController.text = widget.task.title;
    descriptionTextController.text = widget.task.description;
    status = widget.task.status;
    completedTaskList = widget.task.completeTask;
  }

  @override
  Widget build(BuildContext context) {
    // BlocListener<AddTaskBloc, AddTaskState>(
    //     listener: (context, state) {
    //       if (state is AddTaskSuccess) {
    //         Navigator.of(context).pop(true);
    //       } else if (state is AddTaskError) {
    //         ScaffoldMessenger.of(context)
    //             .showSnackBar(SnackBar(content: Text(state.message)));
    //       }
    //     },
    return BlocListener<AddTaskBloc, AddTaskState>(
        listener:(context, state) {
      if (state is AddTaskSuccess) {
                Navigator.of(context).pop(true);
              } else if (state is AddTaskError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
        },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.9,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF111315),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Manage task',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 20,
                              color: AppColors.PrimaryText,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InputTextFieldWidget(
                                  hintText: "Title",
                                  validator: (p0) {},
                                  onSubmit: (p0) {},
                                  readOnly: true,
                                  titalFocusNode: titalFocusNode,
                                  titalTextController: titalTextController),
                              SizedBox(height: 10),
                              InputTextFieldWidget(
                                  hintText: "Discription",
                                  validator: (p0) {},
                                  onSubmit: (p0) {},
                                  readOnly: true,
                                  titalFocusNode: descriptionFocusNode,
                                  titalTextController:
                                  descriptionTextController),
                              SizedBox(height: 10),
                              Align(
                                alignment: AlignmentDirectional(-1, -1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 20, 0),
                                      child: Text(
                                        'Status',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 15,
                                          color: AppColors.SecondaryText,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.sizeOf(context).width *
                                          0.3,
                                      child: DropdownButtonFormField<String>(
                                        value: status,
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: AppColors.white,
                                          letterSpacing: 0,
                                        ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: AppColors.SecondaryText,
                                          size: 24,
                                        ),
                                        elevation: 2,
                                        dropdownColor:
                                        AppColors.PrimaryBackground,
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        decoration: InputDecoration(
                                          hintText: 'Please select...',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: AppColors.SecondaryText,
                                            letterSpacing: 0,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.SecondaryText,
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            status = newValue!;
                                          });
                                        },
                                        items: AppState.Status.map<
                                            DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: AlignmentDirectional(-1, -1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 15),
                                  child: Text(
                                    'Tasks',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 15,
                                      color: AppColors.white,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(
                                    widget.task.tasks.length,
                                        (index) => Theme(
                                      data: ThemeData(
                                        checkboxTheme: CheckboxThemeData(
                                          visualDensity:
                                          VisualDensity.compact,
                                          materialTapTargetSize:
                                          MaterialTapTargetSize
                                              .shrinkWrap,
                                        ),
                                        unselectedWidgetColor:
                                        AppColors.SecondaryText,
                                      ),
                                      child: CheckboxListTile(
                                        value: completedTaskList.where((element) => element == widget.task.tasks[index]).length != 0,
                                        onChanged: (newValue) {
                                          setState(() {
                                            newValue! ?
                                            completedTaskList.add(widget.task.tasks[index]) : completedTaskList.remove(widget.task.tasks[index]);
                                          });
                                        },
                                        title: Text(
                                          widget.task.tasks[index],
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            fontSize: 15,
                                            color: AppColors.white,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        activeColor: AppColors.Primary,
                                        tileColor:
                                        AppColors.SecondaryBackground,
                                        checkColor: AppColors.white,
                                        dense: true,
                                        controlAffinity:
                                        ListTileControlAffinity
                                            .leading,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: 40,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  0, 15, 15, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColors.SecondaryBackground),
                                    elevation: MaterialStatePropertyAll(0),
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsetsDirectional.fromSTEB(
                                            24, 0, 24, 0)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: AppColors.Warning,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ))),
                                child: Text(
                                  'close',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: AppColors.Warning,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.2,
                                height: 40,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    0, 15, 15, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Task task = Task(
                                        id: widget.task!.id,
                                        title: widget.task!.title,
                                        description:
                                        widget.task!.description,
                                        priority: widget.task!.priority,
                                        status: status,
                                        startTime: widget.task!.startTime,
                                        endTime: widget.task!.endTime,
                                        tasks: widget.task!.tasks,
                                        completeTask: completedTaskList
                                    );
                                    context
                                        .read<AddTaskBloc>()
                                        .add(UpdateExistingTask(task));
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll(
                                          AppColors.SecondaryBackground),
                                      elevation: MaterialStatePropertyAll(0),
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 0, 24, 0)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: AppColors.white,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ))),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: AppColors.white,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
