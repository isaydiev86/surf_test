import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:surf_test/domain/models/user.dart';
import 'package:surf_test/domain/services/user_service.dart';
import 'package:surf_test/resources/surftest_colors.dart';
import 'package:surf_test/resources/surftest_images.dart';
import 'package:surf_test/widgets/users_error_widget.dart';

class UsersSliverPage extends StatefulWidget {
  @override
  _UsersSliverPageState createState() => _UsersSliverPageState();
}

class _UsersSliverPageState extends State<UsersSliverPage> {
  final ScrollController _scrollController = ScrollController();
  bool visibleAppBar = true;
  bool isScrolling = false;
  late Future<List<User>> userListFuture;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 0) {
        if (!isScrolling) {
          isScrolling = true;
          visibleAppBar = false;
          setState(() {});
        }
      }

      if (_scrollController.offset == 0) {
        if (isScrolling) {
          isScrolling = false;
          visibleAppBar = true;
          setState(() {});
        }
      }
      setState(() {});
    });
    userListFuture = getAllUsers();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            !visibleAppBar ? SliverAppBar(
              backgroundColor: Colors.white,
              title: Text('Пользователи', style: TextStyle(color: Colors.black, fontSize: 18),),
              expandedHeight: 1,
              pinned: true,
            ) : SliverToBoxAdapter(child: const SizedBox(height: 1)),
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Пользователи',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              centerTitle: false,
              floating: true,
            ),
            FutureBuilder<List<User>>(
                future: userListFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SliverFillRemaining(
                      child: UsersErrorWidget(
                        onTap: () {
                          setState(() {
                            userListFuture = getAllUsers();
                          });
                        },
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
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
                        childCount: snapshot.data!.length, // 1000 list items
                      ),
                    );
                  }
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            SurfTestColors.primaryColor),
                        strokeWidth: 3,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
