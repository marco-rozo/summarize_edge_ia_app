import 'package:equatable/equatable.dart';

class AiModelEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String downloadUrl;
  final String fileName;
  final int sizeInBytes;
  final String version;
  final bool isActive;

  const AiModelEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.downloadUrl,
    required this.fileName,
    required this.sizeInBytes,
    required this.version,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    downloadUrl,
    fileName,
    sizeInBytes,
    version,
    isActive,
  ];
}
