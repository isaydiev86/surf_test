import 'package:flutter/material.dart';
import 'package:surf_test/domain/models/user.dart';
import 'package:surf_test/domain/services/user_service.dart';
import 'package:surf_test/resources/surftest_colors.dart';
import 'package:surf_test/resources/surftest_images.dart';
import 'package:surf_test/widgets/title_users_widget.dart';
import 'package:surf_test/widgets/users_error_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final ScrollController _scrollController = ScrollController();
  bool _scroll = true;
  late Future<List<User>> userListFuture;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {});
    });
    userListFuture = getAllUsers();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _onStartScroll(ScrollMetrics metrics) {
    setState(() {
      _scroll = false;
    });
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    setState(() {
      if (metrics.pixels == 0) {
        _scroll = true;
      } else {
        _scroll = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Пользователи",
          style: TextStyle(
              color: !_scroll ? Colors.black : Colors.white, fontSize: 18),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<User>>(
            future: userListFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _scroll ? TitleUsersWidget() : const SizedBox(height: 0),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              minVerticalPadding: 10,
                              leading: Image.asset(
                                SurfTestImages.userNoAvatar,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                snapshot.data![index].username,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].email,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: SurfTestColors.emailInCardColor),
                                  ),
                                  Text(
                                    snapshot.data![index].company.name,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollStartNotification) {
                            _onStartScroll(scrollNotification.metrics);
                          } else if (scrollNotification
                              is ScrollUpdateNotification) {
                            _onUpdateScroll(scrollNotification.metrics);
                          }
                          return true;
                        },
                      ),
                    ),
                  ],
                );
              }
              //todo чтобы получить ошибку можно отрубить интернет
              if (snapshot.hasError) {
                return UsersErrorWidget(
                  onTap: () {
                    setState(() {
                      userListFuture = getAllUsers();
                    });
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      SurfTestColors.primaryColor),
                  strokeWidth: 3,
                ),
              );
            }),
      ),
    );
  }
}
