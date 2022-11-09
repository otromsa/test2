/**
 * Created by Home on 29/07/2022.
 */

public with sharing class ContactTriggerTestDataFactory {
    public static List<Contact> getListOfContacts(Integer amount, Id accountId) {

        List<Contact> contacts = new List<Contact>();

        for (Integer currentAmount = 0; currentAmount < amount; ++currentAmount) {
            contacts.add(new Contact(LastName='Test ' + currentAmount, AccountId=accountId));
        }

        return contacts;
    }

    public static Id insertNewAccount() {

        Account account = new Account(Name='Test');

        insert account;

        return account.Id;
    }

    public static List<Contact> modifyAccountIdsInContactList(List<Contact> contacts, Id accountId) {

        List<Contact> modifiedContacts = new List<Contact>();

        for (Contact contact: contacts) {

            contact.AccountId = accountId;

            modifiedContacts.add(contact);
        }

        return modifiedContacts;
    }
}