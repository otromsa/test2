@IsTest
private class AccountServiceTest {

    private static List<Account> testAccts = new List<Account>();
    private static List<Contact> testconts1 = new List<Contact>();
    private static List<Contact> testConts99 = new List<Contact>();
    private static List<Contact> testConts101 = new List<Contact>();

    @testSetup static void setup() {

        for(Integer i=0; i<3; i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;

        Contact cont = New Contact(lastName='Test', AccountId=testAccts[0].Id);
        testconts1.add(cont);
        insert testconts1;

        for(Integer i=0;i<99;i++) {
            testConts99.add(New Contact(lastName='TestCont'+i, AccountId=testAccts[1].Id));
        }
        insert testConts99;

        for(Integer i=0;i<101;i++) {
            testConts101.add(New Contact(lastName='TestCont'+i, AccountId=testAccts[2].Id));
        }
        insert testConts101;
    }


    @IsTest
    static void validateAccountType_personal() {

        Test.startTest();
        AccountService.updateAccounts(testconts1);
        Test.stopTest();

        List<Account> accs = [SELECT Id, Name, Type__c FROM Account WHERE Name = 'TestAcct0' AND Type__c = 'Personal'];
        System.assertEquals(1, accs.size());
    }

    @IsTest
    static void validateAccountType_business() {

        Test.startTest();
        AccountService.updateAccounts(testConts99);
        Test.stopTest();

        List<Account> accs = [SELECT Id, Name, Type__c FROM Account WHERE Name = 'TestAcct1' AND Type__c = 'Business'];
        System.assertEquals(1, accs.size());
    }

    @IsTest
    static void validateAccountType_company() {

        Test.startTest();
        AccountService.updateAccounts(testConts101);
        Test.stopTest();

        List<Account> accs = [SELECT Id, Name, Type__c FROM Account WHERE Name = 'TestAcct2' AND Type__c = 'Company'];
        System.assertEquals(1, accs.size());
    }
}