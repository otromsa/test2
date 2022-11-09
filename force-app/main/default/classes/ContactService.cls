public with sharing class ContactService {
    public static void setTypeForAccount(List<Contact> contacts) {
        Set<Id> accountsIds = new Set<Id>();

        for (Contact con : contacts) {
            accountsIds.add(con.AccountId);
        }

        if (accountsIds.isEmpty()) {
            return;
        }

        Map<Id, Integer> accContactsCount = ContactSelector.getAmountOfContactsForAccount(accountsIds);
        List<Account> accounts = new List<Account>();

        for (Id accountId : accContactsCount.keySet()) {
            String accountType = null;
            Integer amountOfContacts = accContactsCount.get(accountId);

            if (amountOfContacts == 1) {
                accountType = 'Personal';
            } else if (amountOfContacts > 1 && amountOfContacts < 100) {
                accountType = 'Business';
            } else if (amountOfContacts >= 100) {
                accountType = 'Company';
            }

            accounts.add(new Account(Id = accountId, Type__c = accountType));
        }

        update accounts;
    }
}