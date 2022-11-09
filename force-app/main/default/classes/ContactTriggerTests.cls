@IsTest
private class ContactTriggerTests {

    @IsTest
    static void ContactTriggerHandler_AccountAmountOfCasesEqualsZeroContactAdded_AccountTypePersonal() {
        // Arrange
        String expectedType = 'Personal';

        Id accountId = ContactTriggerTestDataFactory.insertNewAccount();

        // Act
        Test.startTest();

        insert new Contact(LastName='Test', AccountId=accountId);

        String actualType = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        Test.stopTest();

        // Assert
        System.assertEquals(expectedType, actualType);
    }

    @IsTest
    static void ContactTriggerHandler_AccountAmountOfCasesEqualsZeroTenContactsAdded_AccountTypeBusiness() {
        // Arrange
        String expectedType = 'Business';

        Id accountId = ContactTriggerTestDataFactory.insertNewAccount();

        // Act
        Test.startTest();

        insert ContactTriggerTestDataFactory.getListOfContacts(10, accountId);

        String actualType = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        Test.stopTest();

        // Assert
        System.assertEquals(expectedType, actualType);
    }

    @IsTest
    static void ContactTriggerHandler_AccountAmountOfCasesEqualsOneHundredAllContactsRemoved_AccountTypeNull() {
        // Arrange
        String expectedTypeAfterInsertion = 'Company';

        Id accountId = ContactTriggerTestDataFactory.insertNewAccount();

        List<Contact> contacts = ContactTriggerTestDataFactory.getListOfContacts(100, accountId);

        // Act
        Test.startTest();

        insert contacts;

        String actualTypeAfterInsertion = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        delete contacts;

        String actualTypeAfterDeletion = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        Test.stopTest();

        // Assert
        System.assertEquals(expectedTypeAfterInsertion, actualTypeAfterInsertion);
        System.assert(actualTypeAfterDeletion == null);
    }

    @IsTest
    static void ContactTriggerHandler_AccountTypeEqualsCompanyAmountOfContactsChangedToLessThanOneHundred_AccountTypeBusiness() {
        // Arrange
        String expectedType = 'Business';

        Id accountId = ContactTriggerTestDataFactory.insertNewAccount();

        List<Contact> contacts = ContactTriggerTestDataFactory.getListOfContacts(100, accountId);

        // Act
        Test.startTest();

        insert contacts;

        contacts.get(0).AccountId = null;

        update contacts;

        String actualType = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        Test.stopTest();

        // Assert
        System.assertEquals(expectedType, actualType);
    }

    @IsTest
    static void ContactTriggerHandler_AccountTypeEqualsPersonalOneContactDeletedAndRestored_AccountTypePersonal() {
        // Arrange
        String expectedTypeBeforeDeletion = 'Personal';

        String expectedTypeAfterDeletion = null;

        String expectedTypeAfterRecovery = 'Personal';

        Id accountId = ContactTriggerTestDataFactory.insertNewAccount();

        Contact contact = new Contact(LastName='Test', AccountId=accountId);

        // Act
        Test.startTest();

        insert contact;

        String actualTypeBeforeDeletion = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        delete contact;

        String actualTypeAfterDeletion = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        undelete contact;

        String actualTypeAfterRecovery = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        Test.stopTest();

        // Assert
        System.assertEquals(expectedTypeBeforeDeletion, actualTypeBeforeDeletion);
        System.assertEquals(expectedTypeAfterDeletion, actualTypeAfterDeletion);
        System.assertEquals(expectedTypeAfterRecovery, actualTypeAfterRecovery);
    }

    @IsTest
    static void ContactTriggerHandler_AccountTypeNullUpdatedOneHundredContactsToReferenceAccount_AccountTypeCompany() {
        // Arrange
        String expectedTypeAfterContactsUpdate = 'Company';

        Id accountId = ContactTriggerTestDataFactory.insertNewAccount();

        List<Contact> contacts = ContactTriggerTestDataFactory.getListOfContacts(100, null);

        // Act
        Test.startTest();

        insert contacts;

        String actualTypeBeforeContactsUpdate = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        update ContactTriggerTestDataFactory.modifyAccountIdsInContactList(contacts, accountId);

        String actualTypeAfterContactsUpdate = [SELECT Id, Type__c FROM Account WHERE Id =: accountId].Type__c;

        Test.stopTest();

        // Assert
        System.assert(actualTypeBeforeContactsUpdate == null);
        System.assertEquals(expectedTypeAfterContactsUpdate, actualTypeAfterContactsUpdate);
    }
}