abstract class ExternalPermissionEntity {
  final String clientUuid;
  final String permission;
  final String roleId;
  final String roleGroupUuid;

  ExternalPermissionEntity({
    required this.clientUuid,
    required this.permission,
    required this.roleId,
    required this.roleGroupUuid,
  });
}
