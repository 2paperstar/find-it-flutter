import 'package:find_it/app/modules/post/data/data_source/remote/image_api.dart';
import 'package:find_it/app/modules/post/data/data_source/remote/post_api.dart';
import 'package:find_it/app/modules/post/data/models/post_creation_model.dart';
import 'package:find_it/app/modules/post/data/models/post_list_query_model.dart';
import 'package:find_it/app/modules/post/domain/entities/post_creation_entity.dart';
import 'package:find_it/app/modules/post/domain/entities/post_entity.dart';
import 'package:find_it/app/modules/post/domain/enums/post_type.dart';
import 'package:find_it/app/modules/post/domain/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostRepository)
class RestPostRepository implements PostRepository {
  final PostApi _api;
  final ImageApi _imageApi;

  RestPostRepository(this._api, this._imageApi);

  @override
  Future<List<PostEntity>> getPosts({required PostType type}) async {
    final result = await _api.getPosts(PostListQueryModel(type: type));
    return result.list;
  }

  @override
  Future<List<PostEntity>> getMyPosts({required PostType type}) async {
    final result = await _api.getMyPosts(PostListQueryModel(type: type));
    return result.list;
  }

  @override
  Future<PostEntity> createPost({required PostCreationEntity post}) async {
    final images = post.image.isNotEmpty
        ? await _imageApi.uploadImages(post.image)
        : <String>[];
    final result = await _api.createPost(
      PostCreationModel.fromEntity(entity: post, images: images),
    );
    return result;
  }
}
