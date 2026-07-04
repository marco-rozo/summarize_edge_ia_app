import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/errors/failure.dart';
import 'package:summary_app/modules/home/features/domain/entities/recent_summary_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  Future<void> init() async {
    emit(const HomeLoading());
    await fetchRecentSummaries();
  }

  Future<void> fetchRecentSummaries() async {
    emit(const HomeLoading());
    try {
      // Simula tempo de requisição ao banco de dados ou serviço local
      await Future<void>.delayed(const Duration(milliseconds: 500));

      final mockSummaries = [
        RecentSummaryEntity(
          id: '1',
          type: 'PDF',
          date: DateTime(2023, 10, 24, 14, 30),
          title: 'Relatório de Arquitetura Q3',
          description:
              'Síntese dos padrões de microserviços e migração de banco de dados propostos pela equipe de infraestrutura...',
          metricLabel: 'TOKENS',
          metricValue: '4.2k',
        ),
        RecentSummaryEntity(
          id: '2',
          type: 'ÁUDIO',
          date: DateTime(2023, 10, 22, 9, 15),
          title: 'Reunião Diária - Time Alpha',
          description:
              'Pontos principais abordados na standup, bloqueios na API de pagamentos e resolução prevista para sexta...',
          metricLabel: 'DURAÇÃO',
          metricValue: '15m',
        ),
        RecentSummaryEntity(
          id: '3',
          type: 'DOCX',
          date: DateTime(2023, 10, 18, 16, 45),
          title: 'Especificação Técnica de Produto v2',
          description:
              'Requisitos não funcionais atualizados, SLA definido em 99.9% e matriz de responsabilidades RACI...',
          metricLabel: 'TOKENS',
          metricValue: '12.8k',
        ),
      ];

      if (isClosed) return;
      emit(HomeSuccess(summaries: mockSummaries));
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(
        HomeError(
          failure: UnknownFailure(
            errorMessage: e.toString(),
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }
}
