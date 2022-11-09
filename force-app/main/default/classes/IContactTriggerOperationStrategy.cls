public interface IContactTriggerOperationStrategy {
    void execute(List<Contact> updatedContacts, Map<Id, Contact> oldContacts);
}