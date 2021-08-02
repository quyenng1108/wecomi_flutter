class AccountModel{
  String? accessToken;
  int? accountId;
  String? invalidUsernameMessage;
  String? invalidPasswordMessage;
  AccountModel(this.accessToken,this.accountId,this.invalidUsernameMessage,this.invalidPasswordMessage);
}