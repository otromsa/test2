public with sharing class AccountService {

    public static void updateAccounts(List<Contact> newContacts) {

        Set<ID> accountIds = new Set<ID>();

        for (Contact contact : newContacts) {
            if (contact.AccountId != null) {
                accountIds.add(contact.AccountId);
            }
        }

        List<Account> accountsToUpdate = AccountSelector.getAccountsbyIds(accountIds);

        for (Account acc : accountsToUpdate) {
            Integer contactsQuantity = acc.Contacts.size();
            if (contactsQuantity >= 100) {
                acc.Type__c = 'Company';
            } else if (contactsQuantity == 1) {
                acc.Type__c = 'Personal';
            } else {
                acc.Type__c = 'Business';
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}