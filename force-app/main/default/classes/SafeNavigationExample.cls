public with sharing class SafeNavigationExample {

    /*public static void noSafeNav(){
        String kevinsName = [SELECT Id, Name, BillingStreet FROM Account WHERE Name = 'Kevin' LIMIT 1].Name;
        System.debug('Couldn\'t even get here cause I died');
    }

    public static void safeNav(){
        String kevinsName = [SELECT Id, Name, BillingStreet FROM Account WHERE Name = 'Kevin' LIMIT 1]?.Name;
        System.debug('Sweet safe nav bro');
    }

    public static void safeNavMap(){
        Map<Id, Account> acctMap = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Name = 'sForce']);
        List<Account> acctList = [SELECT Id, Name FROM Account];

        for(Account acct: acctList){
            String matchedAccountName = acctMap.get(acct.Id)?.Name;
        }
    }

    public static void noSafeNavMap(){
        Map<Id, Account> acctMap = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Name = 'sForce']);
        List<Account> acctList = [SELECT Id, Name FROM Account];

        for(Account acct: acctList){
            String matchedAccountName = acctMap.get(acct.Id).Name;
        }
    }*/
}