import 'package:cipers_cluster/controllers/notes_controller.dart';
import 'package:get/get.dart';

import '../controllers/db_controller.dart';

class AppBindings implements Bindings {
  @override
  /*Future<void>*/ void dependencies() /*async*/ {
    Get.lazyPut(() => DBController());
    // await Get.putAsync(() async => await UserController().loadUser());
    // await Get.putAsync(() async => await FeedController().checkAndSeedFeed());
    Get.lazyPut(() => NotesController());
    // Get.create<TaskController>(() => TaskController());
  }
}
