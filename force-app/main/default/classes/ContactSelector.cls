public with sharing class ContactSelector {
    public static Map<Id, Integer> getAmountOfContactsForAccount(Set<Id> accountsIds) {
        Map<Id, Integer> accountContactsCount = new Map<Id, Integer>();

        List<Account> accounts = [
                SELECT Id, (SELECT Id FROM Contacts)
                FROM Account
                WHERE Id IN :accountsIds
        ];

        for (Account acc : accounts) {
            accountContactsCount.put(acc.Id, acc.Contacts.size());
        }

        return accountContactsCount;
    }
}