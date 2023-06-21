import 'package:flutter/material.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/model/repo.dart';
import 'package:task_management/models/project.dart';
import 'package:task_management/views/project/addproject.dart';
import 'package:task_management/views/project/projecttasklistpage.dart';

class ProjectListPage extends StatefulWidget {
  final String projectDivId;

  const ProjectListPage({Key? key, required this.projectDivId}) : super(key: key);

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final AuthController authController = Get.find<AuthController>();
  List<Project> listProject = [];
  List<Project> listProject2 = [];
  List<Project> listProject3 = [];
  projectListRepo repository = projectListRepo();
  projectListRepo2 repository2 = projectListRepo2();
  projectListRepo3 repository3 = projectListRepo3();
  bool loading = false;
  TextEditingController searchController = TextEditingController();


  Future<void> getData() async {
    print("GET DATA LIST PROJECT");
    listProject = await repository.getData(widget.projectDivId);
    listProject2 = await repository2.getData(widget.projectDivId);
    listProject3 = await repository3.getData(widget.projectDivId);
    setState(() {});
    loading = true;
  }

  List<Project> searchResults = [];
  List<Project> searchPendingResults = [];
  List<Project> searchDoneResults = [];

  Future<void> getProjects(String searchText) async {
    print("GET DATA LIST PROJECT");
    listProject = await repository.getData(widget.projectDivId);
    listProject2 = await repository2.getData(widget.projectDivId);
    listProject3 = await repository3.getData(widget.projectDivId);

    if (searchText.isNotEmpty) {
      searchResults = listProject
          .where((project) =>
          project.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || project.projectName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchPendingResults = listProject
          .where((project) =>
          project.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || project.projectName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchDoneResults = listProject
          .where((project) =>
          project.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || project.projectName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    } else {
      searchResults = [];
      searchPendingResults = [];
      searchDoneResults = [];
    }

    setState(() {});
    loading = true;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String projDivId = widget.projectDivId;
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedSearchBar(
            label: "Search Something Here",
            onChanged: (value) {
              setState(() {
                getProjects(value);
              });
            },
          ),
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_box,
                color: Colors.white,
              ),
              onPressed: () {
// do something
                if (authController.currentUser.value?.positionId.toString() == '2') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProject(
                        projectDivId: projDivId,
                      ),
                    ),
                  );
                }
              },
            )
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Aktif',
              ),
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Selesai',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.separated(
              itemCount: searchResults.isNotEmpty ? searchResults.length : listProject.length,
              itemBuilder: (context, index) {
                // final int params = listProject[index].id_proyek;
                final Project project = searchResults.isNotEmpty ? searchResults[index] : listProject[index];
                return ListTile(
                  isThreeLine: true,
                  shape: Border(left: BorderSide(color: Colors.red, width: 5)),
                  title: Text(
                    project.projectName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        project.projectDescription,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_circle),
                          SizedBox(width: 6),
                          Text(project.employeeName.employeeName),
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectTaskListPage(
                          projectId: project.projectId.toString(),
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
            ListView.separated(
              // itemCount: listProject3 != null ? listProject3.length : 0,
              itemCount: searchPendingResults.isNotEmpty ? searchPendingResults.length : listProject3.length,
              itemBuilder: (context, index) {
                final Project project = searchPendingResults.isNotEmpty ? searchPendingResults[index] : listProject3[index];
                return ListTile(
                  isThreeLine: true,
                  shape: Border(left: BorderSide(color: Colors.yellow, width: 5)),
                  title: Text(
                    // listProject3[index].projectName,
                    project.projectName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        // listProject3[index].projectDescription,
                        project.projectDescription,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_circle),
                          SizedBox(width: 6),
                          Text(
                            // listProject3[index].employeeName.employeeName,
                            project.employeeName.employeeName,
                          ),
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectTaskListPage(
                          projectId: project.projectId.toString(),
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
            ListView.separated(
              // itemCount: listProject2 != null ? listProject2.length : 0,
              itemCount: searchDoneResults.isNotEmpty ? searchDoneResults.length : listProject2.length,
              itemBuilder: (context, index) {
                final Project project = searchDoneResults.isNotEmpty ? searchDoneResults[index] : listProject2[index];
                return ListTile(
                  isThreeLine: true,
                  shape: Border(left: BorderSide(color: Colors.green, width: 5)),
                  title: Text(
                    // listProject2[index].projectName,
                    project.projectName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        // listProject2[index].projectDescription,
                        project.projectDescription,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_circle),
                          SizedBox(width: 6),
                          Text(
                            // listProject2[index].employeeName.employeeName,
                            project.employeeName.employeeName,
                          ),
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectTaskListPage(
                                  // projectId: listProject2[index].projectId.toString(),
                                  projectId: project.projectId.toString(),
                                )));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ],
        ),
      ),
    );
  }
}
