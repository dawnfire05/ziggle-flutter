import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notice_reaction_entity.dart';

part 'notice_reaction_model.freezed.dart';
part 'notice_reaction_model.g.dart';

@freezed
class NoticeReactionModel
    with _$NoticeReactionModel
    implements NoticeReactionEntity {
  const NoticeReactionModel._();

  const factory NoticeReactionModel({
    required String emoji,
    required int count,
    required bool isReacted,
  }) = _NoticeReactionModel;

  factory NoticeReactionModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeReactionModelFromJson(json);
  factory NoticeReactionModel.fromEntity(NoticeReactionEntity entity) =>
      NoticeReactionModel(
        emoji: entity.emoji,
        count: entity.count,
        isReacted: entity.isReacted,
      );
}
