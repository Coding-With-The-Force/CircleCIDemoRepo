@isTest
public with sharing class CaseCreator_Test {
  public static testMethod void testCases() {
    CaseCreator.createCase();
    List<Case> caseList = [SELECT Id FROM Case];
    System.assertEquals(2, caseList.size());
    //Hi this is Matt 
  }
}