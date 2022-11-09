public with sharing class SetAccountTypeHelper {
    public static void execute(Integer amountOfContacts, Id accountId, Map<Id, Account> accountsSpecified) {

        if (amountOfContacts == 0) {
            if (accountsSpecified.get(accountId).Type__c != null) {
                accountsSpecified.get(accountId).Type__c = null;
            }
        } else if (amountOfContacts == 1) {
            if (accountsSpecified.get(accountId).Type__c != 'Personal') {
                accountsSpecified.get(accountId).Type__c = 'Personal';
            }
        } else if (amountOfContacts < 100) {
            if (accountsSpecified.get(accountId).Type__c != 'Business') {
                accountsSpecified.get(accountId).Type__c = 'Business';
            }
        } else {
            if (accountsSpecified.get(accountId).Type__c != 'Company') {
                accountsSpecified.get(accountId).Type__c = 'Company';
            }
        }
    }
}