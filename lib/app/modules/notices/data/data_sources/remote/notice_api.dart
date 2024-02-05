import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ziggle/gen/strings.g.dart';

import '../../../domain/enums/notice_sort.dart';
import '../../enums/notice_my.dart';
import '../../models/notice_list_model.dart';
import '../../models/notice_model.dart';

part 'notice_api.g.dart';

@injectable
@RestApi(baseUrl: 'notice/')
abstract class NoticeApi {
  @factoryMethod
  factory NoticeApi(Dio dio) = _NoticeApi;

  @GET('')
  Future<NoticeListModel> getNotices({
    @Query('offset') int? offset,
    @Query('limit') int? limit,
    @Query('lang') AppLocale? lang,
    @Query('search') String? search,
    @Query('tags[]') List<String>? tags,
    @Query('orderBy') NoticeSort? orderBy,
    @Query('my') NoticeMy? my,
  });

  @GET('{id}')
  Future<NoticeModel> getNotice(
    @Path('id') int id, {
    @Query('isViewed') bool isViewed = false,
  });

  @POST('{id}/reaction')
  Future<NoticeModel> addReaction(
    @Path('id') int id,
    @Field('emoji') String emoji,
  );

  @DELETE('{id}/reaction')
  Future<NoticeModel> removeReaction(
    @Path('id') int id,
    @Field('emoji') String emoji,
  );
}
