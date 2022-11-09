public class ContactTriggerOperationStrategyContext {

    private IContactTriggerOperationStrategy strategy;

    public void setStrategy(IContactTriggerOperationStrategy strategy) {
        this.strategy = strategy;
    }

    public void execute(List<Contact> updatedContacts, Map<Id, Contact> oldContacts) {
        strategy.execute(updatedContacts, oldContacts);
    }
}