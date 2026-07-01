enum PermissionManagerStatusEnum {
  /// O usuário negou o acesso.
  denied,

  /// O usuário permitiu o acesso.
  granted,

  /// O sistema operacional negou acesso ao recurso solicitado.
  /// O usuário não pode alterar o status deste aplicativo,
  /// possivelmente devido a restrições ativas, como controle parental.
  /// *Suportado apenas em iOS.*
  restricted,

  /// O usuário autorizou este aplicativo para acesso limitado.
  /// *Suportado apenas em iOS. (iOS14+).*
  limited,

  /// Permissão negada permanentemente. Neste caso a caixa de diálogo
  /// de permissão não será mostrada, deve o usuário acessar as configurações
  /// para permitir novamente.
  permanentlyDenied,

  /// O aplicativo está provisoriamente autorizado a postar notificações
  /// de usuário ininterruptas.
  /// *Suportado apenas em iOS. (iOS12+).*
  provisional,
}
