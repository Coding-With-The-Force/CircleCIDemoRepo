public with sharing class CaseCreator {
  public static void createCase() {
    Case newCase = new Case();
    newCase.Subject = 'Hi there';
    newCase.Status = 'New';
    String acctName = [SELECT Id, Name FROM Account WHERE Name = 'Kevin' LIMIT 1]?.Name;
    System.debug('This is the account name ::: ' + acctName);
    //Inserting cases attempt 5
    insert newCase;
  }
}