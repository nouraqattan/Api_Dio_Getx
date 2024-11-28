import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/post_model.dart';

class PostController extends GetxController {
  final Dio dio = Dio();
  var posts = <PostModel>[].obs;
  var isLoading = false.obs;

  Future fetchPosts() async {
    try {
      isLoading.value = true;
      final response =
      await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        posts.value = (response.data as List)
            .map((post) => PostModel.fromJson(post))
            .toList();
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }
}
