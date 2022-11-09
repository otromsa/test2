public with sharing class ContactTriggerAfterUpdateStrategy implements IContactTriggerOperationStrategy {
    public void execute(List<Contact> updatedContacts, Map<Id, Contact> oldContacts) {

        Set<Id> accountIds = new Set<Id>();

        for (Contact contact : updatedContacts) {
            if (contact.AccountId != oldContacts.get(contact.Id).AccountId) {

                if (contact.AccountId != null) {

                    accountIds.add(contact.AccountId);
                }
                if (oldContacts.get(contact.Id).AccountId != null) {

                    accountIds.add(oldContacts.get(contact.Id).AccountId);
                }
            }
        }

        ContactService.execute(accountIds);
    }
}