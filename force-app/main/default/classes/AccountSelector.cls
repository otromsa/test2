public with sharing class AccountSelector {

    public static List<Account> getAccountsbyIds(Set<Id> accountIDs) {
        return [SELECT Id, Type__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN : accountIDs];
    }
}