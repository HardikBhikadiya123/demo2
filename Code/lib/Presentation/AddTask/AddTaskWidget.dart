import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Presentation/AddTask/add_task_bloc.dart';
import 'package:demo2/Presentation/AddTask/add_task_event.dart';
import 'package:demo2/Presentation/AddTask/add_task_state.dart';
import 'package:demo2/componants/InputTextFieldWidget.dart';
import 'package:demo2/componants/appState.dart';
import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTaskWidget extends StatefulWidget {
  final int? lastTaskId;
  final bool isitForEdit;
  final Task? task;

  const AddTaskWidget({
    super.key,
    this.lastTaskId,
    required this.isitForEdit,
    this.task,
  });

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  TextEditingController titalTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  FocusNode titalFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  List<TextEditingController> textcontroller = [];
  String priority = AppState.Priority.first;
  String status = AppState.Status.first;
  DateTime statrDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateFormat dateFormat = DateFormat("MMM dd, yyyy");
  var _formkey = GlobalKey<FormState>();
  var _formkey2 = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isitForEdit
        ? initlizeControllers()
        : setState(() {
            textcontroller.add(TextEditingController());
          });
  }

  initlizeControllers() {
    widget.task!.tasks.forEach((element) {
      textcontroller.add(TextEditingController(text: element));
    });
    setState(() {
      titalTextController.text = widget.task!.title;
      descriptionTextController.text = widget.task!.description;
      priority = widget.task!.priority;
      status = widget.task!.status;
      statrDate = widget.task!.startTime;
      endDate = widget.task!.endTime;
    });
  }

  datePicer() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        List<DateTime?> selectedDate = [];
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment:
              AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
          child: Container(
              width: 440,
              height: 440,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.range),
                    displayedMonthDate: DateTime.now(),
                    value: [DateTime.now()],
                    onValueChanged: (dates) {
                      selectedDate = dates;
                    },
                  ),
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
                                    EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 24, 0)),
                                elevation: MaterialStatePropertyAll(0),
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
                              if (selectedDate.length == 2 &&
                                  (selectedDate.first!.microsecond >=
                                      DateTime.now().microsecond) &&
                                  (selectedDate.last!.microsecond >=
                                      selectedDate.first!.microsecond)) {
                                statrDate = selectedDate.first!;
                                endDate = selectedDate.last!;
                                setState(() {});
                                Navigator.of(context).pop(true);
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return AlertDialog(
                                      alignment: Alignment.center,
                                      backgroundColor: AppColors.white,
                                      shadowColor: AppColors.white,
                                      actions: [
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Container(
                                            height: 40,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 15, 15, 0),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                              style: ButtonStyle(
                                                  padding:
                                                      MaterialStatePropertyAll(
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24, 0, 24, 0)),
                                                  elevation:
                                                      MaterialStatePropertyAll(
                                                          3),
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          AppColors.white),
                                                  shape:
                                                      MaterialStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: AppColors.Black,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ))),
                                              child: Text('Close',
                                                  style: TextStyle(
                                                    fontFamily: 'Readex Pro',
                                                    color: AppColors.Black,
                                                    letterSpacing: 0,
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                      title: Text("Date Range is not Valide.",
                                          style: TextStyle(
                                              color: AppColors.Error,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                      content: Text(
                                          selectedDate.length != 2
                                              ? "Date range is Empty!"
                                              : "Invalide Range ",
                                          style: TextStyle(
                                              color:
                                                  AppColors.PrimaryBackground,
                                              fontSize: 14)),
                                    );
                                  },
                                );
                              }
                            },
                            style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 24, 0)),
                                elevation: MaterialStatePropertyAll(0),
                                backgroundColor:
                                    MaterialStatePropertyAll(AppColors.white),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.Primary,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ))),
                            child: Text('Ok',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: AppColors.Primary,
                                  letterSpacing: 0,
                                )),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    titalTextController.dispose();
    descriptionTextController.dispose();
    titalFocusNode.dispose();
    descriptionFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) {
          Navigator.of(context).pop(true);
        } else if (state is AddTaskError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Column(
        children: [
          Flexible(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              margin: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 25),
              decoration: BoxDecoration(
                  color: Color(0xFF111315),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.SecondaryBackground,
                      blurRadius: 50,
                    )
                  ]),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Add Task',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 20,
                              color: AppColors.PrimaryText,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InputTextFieldWidget(
                                  hintText: "Title",
                                  validator: (p0) {
                                    if (p0.trim().length == 0) {
                                      return "Task Title is Empty";
                                    }
                                  },
                                  onSubmit: (p0) {},
                                  readOnly: false,
                                  titalFocusNode: titalFocusNode,
                                  titalTextController: titalTextController),
                              SizedBox(height: 10),
                              InputTextFieldWidget(
                                  hintText: "Discription",
                                  validator: (p0) {},
                                  onSubmit: (p0) {},
                                  readOnly: false,
                                  titalFocusNode: descriptionFocusNode,
                                  titalTextController:
                                      descriptionTextController),
                              SizedBox(height: 10),
                              Align(
                                alignment: AlignmentDirectional(-1, -1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Wrap(
                                    spacing: 50,
                                    runSpacing: 10,
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: Text(
                                              'Priority',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: AppColors.PrimaryText,
                                                fontSize: 15,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 300,
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: priority,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: AppColors.PrimaryText,
                                                fontSize: 14,
                                                letterSpacing: 0,
                                              ),
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: AppColors.SecondaryText,
                                                size: 24,
                                              ),
                                              elevation: 2,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              dropdownColor:
                                                  AppColors.PrimaryBackground,
                                              decoration: InputDecoration(
                                                hintText: 'Please select...',
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  color:
                                                      AppColors.SecondaryText,
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        AppColors.SecondaryText,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  priority = newValue!;
                                                });
                                              },
                                              items: AppState.Priority.map<
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
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: Text(
                                              'Status',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 15,
                                                color: AppColors.white,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 300,
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: status,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: AppColors.PrimaryText,
                                                fontSize: 15,
                                                letterSpacing: 0,
                                              ),
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
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
                                                  color:
                                                      AppColors.SecondaryText,
                                                  letterSpacing: 0,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        AppColors.SecondaryText,
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
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: AlignmentDirectional(-1, -1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Task Duration ',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 15,
                                          color: AppColors.white,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          datePicer();
                                        },
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Color(0x65DEE4FF),
                                                  width: 2,
                                                ),
                                              ),
                                              child: Text(
                                                "${dateFormat.format(statrDate)}  To  ${dateFormat.format(endDate)}",
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  color: AppColors.white,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: AlignmentDirectional(-1, -1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Text(
                                    'Add Tasks',
                                    style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 15,
                                        letterSpacing: 0,
                                        color: AppColors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Builder(
                                  builder: (context) {
                                    final task = textcontroller;
                                    return Form(
                                      key: _formkey2,
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: task.length,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: 10),
                                        itemBuilder: (context, taskIndex) {
                                          final taskItem = task[taskIndex];
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: InputTextFieldWidget(
                                                    titalTextController:
                                                        taskItem,
                                                    readOnly: false,
                                                    titalFocusNode: FocusNode(),
                                                    onSubmit: (p0) {
                                                      textcontroller[
                                                              taskIndex] =
                                                          TextEditingController(
                                                              text: p0);
                                                    },
                                                    validator: (p0) {
                                                      if (p0.trim().length ==
                                                          0) {
                                                        return "Task is Empty";
                                                      }
                                                    },
                                                    hintText: "Task"),
                                              ),
                                              textcontroller.length != 1
                                                  ? SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child: IconButton(
                                                        style: ButtonStyle(
                                                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                            ))),
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color:
                                                              AppColors.Error,
                                                          size: 30,
                                                        ),
                                                        onPressed: () async {
                                                          textcontroller
                                                              .removeAt(
                                                                  taskIndex);
                                                          setState(() {});
                                                        },
                                                      ),
                                                    )
                                                  : SizedBox.shrink(),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1, -1),
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      textcontroller
                                          .add(TextEditingController());
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsetsDirectional.fromSTEB(
                                                24, 0, 24, 0)),
                                        elevation: MaterialStatePropertyAll(3),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                AppColors.PrimaryBackground),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Color(0x65DEE4FF),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ))),
                                    child: Text('ADD +',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: AppColors.white,
                                          letterSpacing: 0,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Container(
                              height: 40,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 15, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsetsDirectional.fromSTEB(
                                            24, 0, 24, 0)),
                                    elevation: MaterialStatePropertyAll(3),
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColors.PrimaryBackground),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: AppColors.Warning,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ))),
                                child: Text('Close',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: AppColors.Warning,
                                      letterSpacing: 0,
                                    )),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Container(
                              height: 40,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 15, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate() &&
                                      _formkey2.currentState!.validate()) {
                                    List<String> tasts = textcontroller
                                        .map((e) => e.text.toString())
                                        .toList();
                                    Task task = Task(
                                        id: widget.isitForEdit
                                            ? widget.task!.id
                                            : (widget.lastTaskId! + 1),
                                        title: titalTextController.text,
                                        description:
                                            descriptionTextController.text,
                                        priority: priority,
                                        status: status,
                                        startTime: statrDate,
                                        endTime: endDate,
                                        tasks: tasts,
                                        completeTask: []);
                                    try {
                                      widget.isitForEdit
                                          ? context
                                              .read<AddTaskBloc>()
                                              .add(UpdateExistingTask(task))
                                          : context
                                              .read<AddTaskBloc>()
                                              .add(AddNewTask(task));
                                    } catch (error) {
                                      print("Error ====>$error");
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsetsDirectional.fromSTEB(
                                            24, 0, 24, 0)),
                                    elevation: MaterialStatePropertyAll(3),
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColors.PrimaryBackground),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: AppColors.white,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ))),
                                child: Text(
                                    widget.isitForEdit ? 'Update' : 'Submit',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: AppColors.white,
                                      letterSpacing: 0,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
