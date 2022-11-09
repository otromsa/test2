@IsTest
private class ContactServiceTest {
    @IsTest
    static void setTypeForAccount_positive() {
        Account acc = TestDataFactory.createAccount();
        insert acc;
        Contact cont = TestDataFactory.createContact(acc.Id);

        Test.startTest();
        insert cont;
        Test.stopTest();

        List<Account> result = [SELECT Type__c FROM Account];
        System.assertEquals('Personal', result[0].Type__c);
    }

    @IsTest
    static void setTypeForAccount_bulk() {
        Account acc1 = TestDataFactory.createAccount();
        insert acc1;
        Account acc2 = TestDataFactory.createAccount();
        insert acc2;

        List<Contact> contacts1 = TestDataFactory.createContactsWithAccount(40, acc1.Id);
        List<Contact> contacts2 = TestDataFactory.createContactsWithAccount(101, acc2.Id);
        contacts1.addAll(contacts2);

        Test.startTest();
        insert contacts1;
        Test.stopTest();

        List<AggregateResult> result = [SELECT COUNT(Id) amount, Account.Type__c FROM Contact GROUP BY Account.Type__c];
        Integer amountOfContacts = (Integer) result[0].get('amount') + (Integer) result[1].get('amount');

        System.assertEquals(contacts1.size(), amountOfContacts);
        System.assertEquals('Business', result[0].get('Type__c'));
        System.assertEquals('Company', result[1].get('Type__c'));
    }

    @IsTest
    static void setTypeForAccount_delete() {
        Account acc = TestDataFactory.createAccount();
        insert acc;

        List<Contact> contacts2 = TestDataFactory.createContactsWithAccount(100, acc.Id);
        insert contacts2;

        Test.startTest();
        delete contacts2[0];
        Test.stopTest();

        List<Account> result = [SELECT Type__c FROM Account];

        System.assertEquals('Business', result[0].Type__c);
    }

    @IsTest
    static void setTypeForAccount_bulkDelete() {
        Account acc = TestDataFactory.createAccount();
        insert acc;
        Contact contact = TestDataFactory.createContact();
        contact.AccountId = acc.Id;
        insert contact;

        Test.startTest();
        delete contact;
        Test.stopTest();

        List<Account> result = [SELECT Type__c FROM Account];

        System.assertEquals(null, result[0].Type__c);
    }

    @IsTest
    static void setTypeForAccount_update() {
        Account account = TestDataFactory.createAccount();
        insert account;
        List<Contact> contacts = TestDataFactory.createContacts(5);
        insert contacts;
        for (Integer i = 0; i < 5; i++) {
            contacts[i].AccountId = account.Id;
        }

        Test.startTest();
        update contacts;
        Test.stopTest();

        List<Account> result = [SELECT Type__c FROM Account ORDER BY Type__c];
        System.assertEquals('Business', result[0].Type__c);
    }

    @IsTest
    static void setTypeForAccount_updateBulk() {
        List<Account> accounts = TestDataFactory.createAccounts(2);
        insert accounts;
        List<Contact> contacts1 = TestDataFactory.createContactsWithAccount(5, accounts[0].Id);
        List<Contact> contacts2 = TestDataFactory.createContactsWithAccount(98, accounts[1].Id);
        insert contacts1;
        insert contacts2;

        for (Integer i = 0; i < contacts1.size() - 1; i++) {
            contacts1[i].AccountId = accounts[1].Id;
        }
        contacts2.addAll(contacts1);

        Test.startTest();
        update contacts2;
        Test.stopTest();

        List<Account> result = [SELECT Type__c FROM Account WHERE Id IN (:accounts[0].Id, :accounts[1].Id)];

        System.assertEquals('Personal', result[0].Type__c);
        System.assertEquals('Company', result[1].Type__c);
    }
}