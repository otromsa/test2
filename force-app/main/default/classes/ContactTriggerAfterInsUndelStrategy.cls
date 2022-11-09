public with sharing class ContactTriggerAfterInsUndelStrategy implements IContactTriggerOperationStrategy {
    public void execute(List<Contact> updatedContacts, Map<Id, Contact> oldContacts) {

        Set<Id> accountIds = new Set<Id>();

        for (Contact contact : updatedContacts) {
            if (contact.AccountId != null) {
                accountIds.add(contact.AccountId);
            }
        }

        ContactService.execute(accountIds);
    }
}