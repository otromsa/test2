public with sharing class ContactTriggerHandler {
    public static void handle(List<Contact> newContacts, System.TriggerOperation triggerOperation) {

        switch on triggerOperation {
            when AFTER_INSERT {
                AccountService.updateAccounts(newContacts);
            }
            when AFTER_UPDATE {
                AccountService.updateAccounts(newContacts);
            }
        }
    }
}