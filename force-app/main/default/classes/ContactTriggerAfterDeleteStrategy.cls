public with sharing class ContactTriggerAfterDeleteStrategy implements IContactTriggerOperationStrategy {
    public void execute(List<Contact> updatedContacts, Map<Id, Contact> oldContacts) {

        Set<Id> accountIds = new Set<Id>();

        for (Contact contact : oldContacts.values()) {
            if (contact.AccountId != null) {
                accountIds.add(contact.AccountId);
            }
        }

        ContactService.execute(accountIds);
    }
}