import 'package:flutter/material.dart';

/// Alert dialog displayed when microphone permission is denied.
class PermissionDeniedDialogWidget extends StatelessWidget {
  const PermissionDeniedDialogWidget({
    super.key,
    required this.isPermanent,
    required this.onOpenSettings,
  });

  /// Whether the permission was permanently denied.
  final bool isPermanent;

  /// Callback to open system settings when permission is permanently denied.
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Permissão necessária'),
      content: Text(
        isPermanent
            ? 'A permissão de microfone foi negada permanentemente. '
                'Abra as configurações do app para permitir o acesso.'
            : 'É necessário permitir o acesso ao microfone para '
                'utilizar a gravação de áudio.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        if (isPermanent)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onOpenSettings();
            },
            child: const Text('Abrir Configurações'),
          ),
      ],
    );
  }
}
