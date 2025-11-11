import 'package:ziggle/app/modules/groups/domain/entities/external_permission_entity.dart';

abstract class UserInfoRoleEntity {
  final List<ExternalPermissionEntity> externalPermissions;
  final String name;
  final String id;
  final String groupUuid;
  final List<String> permissions;

  UserInfoRoleEntity({
    required this.externalPermissions,
    required this.name,
    required this.id,
    required this.groupUuid,
    required this.permissions,
  });
}
