import 'package:ziggle/app/modules/groups/domain/entities/user_info_role_entity.dart';

abstract class UserInfoEntity {
  final UserInfoRoleEntity role;
  final String name;
  final String description;
  final String uuid;
  final DateTime createdAt;
  final DateTime? verifiedAt;
  final String presidentUuid;
  final DateTime? deletedAt;
  final String notionPageId;
  final String profileImageKey;

  UserInfoEntity({
    required this.role,
    required this.name,
    required this.description,
    required this.uuid,
    required this.createdAt,
    this.verifiedAt,
    required this.presidentUuid,
    this.deletedAt,
    required this.notionPageId,
    required this.profileImageKey,
  });
}
