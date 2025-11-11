import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ziggle/app/modules/groups/domain/entities/external_permission_entity.dart';

part 'external_permission_model.freezed.dart';
part 'external_permission_model.g.dart';

@freezed
sealed class ExternalPermissionModel
    with _$ExternalPermissionModel
    implements ExternalPermissionEntity {
  const ExternalPermissionModel._();

  const factory ExternalPermissionModel({
    required String clientUuid,
    required String permission,
    required String roleId,
    required String roleGroupUuid,
  }) = _ExternalPermissionModel;

  factory ExternalPermissionModel.fromJson(Map<String, dynamic> json) =>
      _$ExternalPermissionModelFromJson(json);
}
