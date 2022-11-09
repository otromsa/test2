@IsTest
private class ContactSelectorTest {

    @IsTest
    static void etAmountOfContactsForAccount() {
        Integer amountOfContacts = 40;
        Account acc = TestDataFactory.createAccount();
        insert acc;
        insert TestDataFactory.createContactsWithAccount(amountOfContacts, acc.Id);

        Test.startTest();
        Map<Id, Integer> accountContacts = ContactSelector.getAmountOfContactsForAccount(new Set<Id>{acc.Id});
        Test.stopTest();

        System.assertEquals(amountOfContacts, accountContacts.get(acc.Id));
    }
}