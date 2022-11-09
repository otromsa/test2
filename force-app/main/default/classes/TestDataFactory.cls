@IsTest
public with sharing class TestDataFactory {

    public static Account createAccount() {
        return new Account(Name = 'Test Account');
    }

    public static List<Account> createAccounts(Integer amountOfAcc) {
        List<Account> accounts = new List<Account>();

        for (Integer i = 0; i < amountOfAcc; i++) {
            accounts.add(new Account(Name = 'Test Acc' + i));
        }

        return accounts;
    }

    public static Contact createContact() {
        return new Contact(LastName = 'Test Contact');
    }

    public static Contact createContact(Id accountId) {
        return new Contact(LastName = 'Test Contact', AccountId = accountId);
    }

    public static List<Contact> createContacts(Integer amountOfContacts) {
        List<Contact> contacts = new List<Contact>();

        for (Integer i = 0; i < amountOfContacts; i++) {
            contacts.add(new Contact(LastName = 'Test Contact' + i));
        }

        return contacts;
    }

    public static List<Contact> createContactsWithAccount(Integer amountOfContacts, Id accountId) {
        List<Contact> contacts = new List<Contact>();

        for (Integer i = 0; i < amountOfContacts; i++) {
            contacts.add(new Contact(LastName = 'Test Contact' + i, AccountId = accountId));
        }

        return contacts;
    }
}