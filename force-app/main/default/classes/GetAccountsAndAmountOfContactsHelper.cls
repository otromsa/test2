public with sharing class GetAccountsAndAmountOfContactsHelper {
    public static Map<Id, Integer> execute(Set<Id> accountIds, List<Contact> contacts) {

        Map<Id, Integer> accountsAndAmountOfTheirContacts = new Map<Id, Integer>();

        for (Id AccountId: accountIds) {
            accountsAndAmountOfTheirContacts.put(AccountId, 0);
        }

        for (Contact contact: contacts) {
            accountsAndAmountOfTheirContacts.put(contact.AccountId,
                    accountsAndAmountOfTheirContacts.get(contact.AccountId) + 1);
        }

        return accountsAndAmountOfTheirContacts;
    }
}