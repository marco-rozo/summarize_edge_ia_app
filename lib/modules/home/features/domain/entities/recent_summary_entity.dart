import 'package:equatable/equatable.dart';

class RecentSummaryEntity extends Equatable {
  final String id;
  final String type;
  final DateTime date;
  final String title;
  final String description;
  final String metricLabel;
  final String metricValue;

  const RecentSummaryEntity({
    required this.id,
    required this.type,
    required this.date,
    required this.title,
    required this.description,
    required this.metricLabel,
    required this.metricValue,
  });

  String get formattedDate {
    final months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day $month $year, $hour:$minute';
  }

  @override
  List<Object?> get props => [
        id,
        type,
        date,
        title,
        description,
        metricLabel,
        metricValue,
      ];
}
