import 'package:discuzq/api/threadsAPI.dart';
import 'package:discuzq/api/usersAPI.dart';
import 'package:discuzq/models/threadModel.dart';
import 'package:discuzq/models/userGroupModel.dart';
import 'package:discuzq/models/userModel.dart';
import 'package:discuzq/router/route.dart';
import 'package:discuzq/utils/request/request.dart';
import 'package:discuzq/views/threads/threadDetailDelegate.dart';
import 'package:discuzq/widgets/common/discuzToast.dart';
import 'package:flutter/material.dart';

class ThreadsDetector {
  const ThreadsDetector({this.context});

  final BuildContext context;

  ///
  /// 使用ThreadID 弹出指定的主题
  ///
  Future<void> showThread({@required int threadID, uid}) async {
    if (threadID == null) {
      return;
    }

    final Function close = DiscuzToast.loading();

    try {
      final ThreadModel threadModel =
          await ThreadsAPI(context: context).getDetailByID(threadID: threadID);
      final Map<UserModel, UserGroupModel> user =
          await UsersAPI(context: context).getUserDataByID(uid: uid);

      close();

      if (threadModel == null || user == null) {
        DiscuzToast.toast(
            context: context,
            type: DiscuzToastType.failed,
            title: '打开失败',
            message: '请重新尝试');
        return;
      }

      return DiscuzRoute.open(
          context: context,
          widget: Builder(
            builder: (context) => ThreadDetailDelegate(
              thread: threadModel,
              author: user.keys.first,
            ),
          ));
    } catch (e) {
      close();
      throw e;
    }
  }
}
