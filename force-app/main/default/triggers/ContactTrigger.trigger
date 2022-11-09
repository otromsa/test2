trigger ContactTrigger on Contact (after insert, after update) {

    ContactTriggerHandler.handle(Trigger.New, Trigger.operationType);
}