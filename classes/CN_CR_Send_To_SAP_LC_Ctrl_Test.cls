/**************************************************************************************************
 * Name           : CN_CR_Send_To_SAP_LC_Ctrl_Test
 * Object         : 
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Qiu Chen
 * Create Date    : 2021-06-07
 * Modify History : 
 **************************************************************************************************/
@isTest
private class CN_CR_Send_To_SAP_LC_Ctrl_Test {
    @TestSetup
    static void makeData(){
        TestDataFactory.makeBaseData();
    }
    @isTest
    private static void controllerTest_200() {
        TestDataFactory testDataFactory = new TestDataFactory();

        List<User> userList = [SELECT Id, LastName FROM User];
        Map<String, Id> lastNameUserIdMap = new Map<String, Id>();
        for(User usr: userList) {
            lastNameUserIdMap.put(usr.LastName, usr.Id);
        }

        Talend_Setting__c talendSetting = new Talend_Setting__c();
        talendSetting.Change_Request_Endpoint__c = 'http://127.0.0.1/CR/200';
        talendSetting.Password__c = 'password';
        talendSetting.Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/200';
        talendSetting.Sanbox_Change_Request_Endpoint__c = 'http://127.0.0.1/CR/200';
        talendSetting.Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sanbox_Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/200';
        talendSetting.Sandbox_Password__c = 'password';
        talendSetting.Sandbox_Send_To_Account_Endpoint__c = 'http://127.0.0.1/ACC/200';
        talendSetting.Sandbox_User_Name__c = 'Name';
        talendSetting.Send_to_Account_Endpoint__c = 'http://127.0.0.1/ACC/200';
        talendSetting.User_Name__c = 'Name';
        talendSetting.Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        talendSetting.Sandbox_Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        insert talendSetting;

        Account acc = testDataFactory.makeAccounts(1,false)[0];
        User salesRep = [SELECT Id FROM User WHERE lastName = 'Sales1'][0];

        Id newContactRTId = Schema.SObjectType.CN_Change_Request__c.getRecordTypeInfosByDeveloperName().get(Constants.CN_CR_RT_API_NAME_NEW_CONTACT).getRecordTypeId();
        CN_Change_Request__c cr = new CN_Change_Request__c();
        cr.RecordTypeId = newContactRTId;
        cr.New_CN_Contact_Type__c = '04';
        cr.New_CN_Contact_License_Name__c = acc.Id;
        cr.New_CN_Contact_Title__c = 'CR Contact Title';
        cr.New_CN_Contact_Dept_Of_Contact_Person__c = '0002';
        cr.New_CN_Contact_CN_First_Name__c = 'Contact 01';
        cr.New_CN_Contact_CN_Last_Name__c = 'Test CR';
        cr.New_CN_Contact_Name_EN__c = 'Test CR Contact Name 01';
        cr.New_CN_Contact_Mobile__c = '15755555551';
        cr.New_CN_Contact_Billing_To_Address__c = 'CR Bill to Address';
        cr.CN_Is_Generate_From_Action__c = true;
        cr.CN_Change_Request_Status__c = 'Approved';
        insert cr;

        Test.startTest();
        CN_CR_Send_To_SAP_LC_Ctrl.getCRInfoAndCheckEditPermisison(cr.Id);
        Test.setMock(HTTPCalloutMock.class, new TestHttpMock());
        CN_CR_Send_To_SAP_LC_Ctrl.sendCR(cr.Id);
        try {
            CN_CR_Send_To_SAP_LC_Ctrl.getCRInfoAndCheckEditPermisison('');
        } catch (Exception e) {
            
        }
        try {
            CN_CR_Send_To_SAP_LC_Ctrl.getCRInfoAndCheckEditPermisison('001000000000000');
        } catch (Exception e) {
            
        }
        try {
            CN_CR_Send_To_SAP_LC_Ctrl.sendCR('');
        } catch (Exception e) {
            
        }
        try {
            CN_CR_Send_To_SAP_LC_Ctrl.sendCR('001000000000000');
        } catch (Exception e) {
            
        }
        Test.stopTest();
    }
    @isTest
    private static void controllerTest_500() {
        TestDataFactory testDataFactory = new TestDataFactory();

        List<User> userList = [SELECT Id, LastName FROM User];
        Map<String, Id> lastNameUserIdMap = new Map<String, Id>();
        for(User usr: userList) {
            lastNameUserIdMap.put(usr.LastName, usr.Id);
        }

        Talend_Setting__c talendSetting = new Talend_Setting__c();
        talendSetting.Change_Request_Endpoint__c = 'http://127.0.0.1/CR/500';
        talendSetting.Password__c = 'password';
        talendSetting.Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/500';
        talendSetting.Sanbox_Change_Request_Endpoint__c = 'http://127.0.0.1/CR/500';
        talendSetting.Sanbox_Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/500';
        talendSetting.Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Password__c = 'password';
        talendSetting.Sandbox_Send_To_Account_Endpoint__c = 'http://127.0.0.1/ACC/500';
        talendSetting.Sandbox_User_Name__c = 'Name';
        talendSetting.Send_to_Account_Endpoint__c = 'http://127.0.0.1/ACC/500';
        talendSetting.User_Name__c = 'Name';
        talendSetting.Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        talendSetting.Sandbox_Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        insert talendSetting;

        Account acc = testDataFactory.makeAccounts(1,false)[0];
        User salesRep = [SELECT Id FROM User WHERE lastName = 'Sales1'][0];

        Id newContactRTId = Schema.SObjectType.CN_Change_Request__c.getRecordTypeInfosByDeveloperName().get(Constants.CN_CR_RT_API_NAME_NEW_CONTACT).getRecordTypeId();
        CN_Change_Request__c cr = new CN_Change_Request__c();
        cr.RecordTypeId = newContactRTId;
        cr.New_CN_Contact_Type__c = '04';
        cr.New_CN_Contact_License_Name__c = acc.Id;
        cr.New_CN_Contact_Title__c = 'CR Contact Title';
        cr.New_CN_Contact_Dept_Of_Contact_Person__c = '0002';
        cr.New_CN_Contact_CN_First_Name__c = 'Contact 01';
        cr.New_CN_Contact_CN_Last_Name__c = 'Test CR';
        cr.New_CN_Contact_Name_EN__c = 'Test CR Contact Name 01';
        cr.New_CN_Contact_Mobile__c = '15755555551';
        cr.New_CN_Contact_Billing_To_Address__c = 'CR Bill to Address';
        cr.CN_Is_Generate_From_Action__c = true;
        cr.CN_Change_Request_Status__c = 'Approved';
        insert cr;

        Test.startTest();
        CN_CR_Send_To_SAP_LC_Ctrl.getCRInfoAndCheckEditPermisison(cr.Id);
        Test.setMock(HTTPCalloutMock.class, new TestHttpMock());
        CN_CR_Send_To_SAP_LC_Ctrl.sendCR(cr.Id);
        Test.stopTest();
    }
    @isTest
    private static void controllerTest_400() {
        TestDataFactory testDataFactory = new TestDataFactory();

        List<User> userList = [SELECT Id, LastName FROM User];
        Map<String, Id> lastNameUserIdMap = new Map<String, Id>();
        for(User usr: userList) {
            lastNameUserIdMap.put(usr.LastName, usr.Id);
        }

        Talend_Setting__c talendSetting = new Talend_Setting__c();
        talendSetting.Change_Request_Endpoint__c = 'http://127.0.0.1/CR/400';
        talendSetting.Password__c = 'password';
        talendSetting.Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/400';
        talendSetting.Sanbox_Change_Request_Endpoint__c = 'http://127.0.0.1/CR/400';
        talendSetting.Sanbox_Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/400';
        talendSetting.Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Password__c = 'password';
        talendSetting.Sandbox_Send_To_Account_Endpoint__c = 'http://127.0.0.1/ACC/400';
        talendSetting.Sandbox_User_Name__c = 'Name';
        talendSetting.Send_to_Account_Endpoint__c = 'http://127.0.0.1/ACC/400';
        talendSetting.User_Name__c = 'Name';
        talendSetting.Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        talendSetting.Sandbox_Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        insert talendSetting;

        Account acc = testDataFactory.makeAccounts(1,false)[0];
        User salesRep = [SELECT Id FROM User WHERE lastName = 'Sales1'][0];

        Id newContactRTId = Schema.SObjectType.CN_Change_Request__c.getRecordTypeInfosByDeveloperName().get(Constants.CN_CR_RT_API_NAME_NEW_CONTACT).getRecordTypeId();
        CN_Change_Request__c cr = new CN_Change_Request__c();
        cr.RecordTypeId = newContactRTId;
        cr.New_CN_Contact_Type__c = '04';
        cr.New_CN_Contact_License_Name__c = acc.Id;
        cr.New_CN_Contact_Title__c = 'CR Contact Title';
        cr.New_CN_Contact_Dept_Of_Contact_Person__c = '0002';
        cr.New_CN_Contact_CN_First_Name__c = 'Contact 01';
        cr.New_CN_Contact_CN_Last_Name__c = 'Test CR';
        cr.New_CN_Contact_Name_EN__c = 'Test CR Contact Name 01';
        cr.New_CN_Contact_Mobile__c = '15755555551';
        cr.New_CN_Contact_Billing_To_Address__c = 'CR Bill to Address';
        cr.CN_Is_Generate_From_Action__c = true;
        cr.CN_Change_Request_Status__c = 'Approved';
        insert cr;

        Test.startTest();
        CN_CR_Send_To_SAP_LC_Ctrl.getCRInfoAndCheckEditPermisison(cr.Id);
        Test.setMock(HTTPCalloutMock.class, new TestHttpMock());
        CN_CR_Send_To_SAP_LC_Ctrl.sendCR(cr.Id);
        Test.stopTest();
    }
    @isTest
    private static void controllerTest_401() {
        TestDataFactory testDataFactory = new TestDataFactory();

        List<User> userList = [SELECT Id, LastName FROM User];
        Map<String, Id> lastNameUserIdMap = new Map<String, Id>();
        for(User usr: userList) {
            lastNameUserIdMap.put(usr.LastName, usr.Id);
        }

        Talend_Setting__c talendSetting = new Talend_Setting__c();
        talendSetting.Change_Request_Endpoint__c = 'http://127.0.0.1/CR/401';
        talendSetting.Password__c = 'password';
        talendSetting.Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/401';
        talendSetting.Sanbox_Change_Request_Endpoint__c = 'http://127.0.0.1/CR/401';
        talendSetting.Sanbox_Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/401';
        talendSetting.Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Password__c = 'password';
        talendSetting.Sandbox_Send_To_Account_Endpoint__c = 'http://127.0.0.1/ACC/401';
        talendSetting.Sandbox_User_Name__c = 'Name';
        talendSetting.Send_to_Account_Endpoint__c = 'http://127.0.0.1/ACC/401';
        talendSetting.User_Name__c = 'Name';
        talendSetting.Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        talendSetting.Sandbox_Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        insert talendSetting;

        Account acc = testDataFactory.makeAccounts(1,false)[0];
        User salesRep = [SELECT Id FROM User WHERE lastName = 'Sales1'][0];

        Id newContactRTId = Schema.SObjectType.CN_Change_Request__c.getRecordTypeInfosByDeveloperName().get(Constants.CN_CR_RT_API_NAME_NEW_CONTACT).getRecordTypeId();
        CN_Change_Request__c cr = new CN_Change_Request__c();
        cr.RecordTypeId = newContactRTId;
        cr.New_CN_Contact_Type__c = '04';
        cr.New_CN_Contact_License_Name__c = acc.Id;
        cr.New_CN_Contact_Title__c = 'CR Contact Title';
        cr.New_CN_Contact_Dept_Of_Contact_Person__c = '0002';
        cr.New_CN_Contact_CN_First_Name__c = 'Contact 01';
        cr.New_CN_Contact_CN_Last_Name__c = 'Test CR';
        cr.New_CN_Contact_Name_EN__c = 'Test CR Contact Name 01';
        cr.New_CN_Contact_Mobile__c = '15755555551';
        cr.New_CN_Contact_Billing_To_Address__c = 'CR Bill to Address';
        cr.CN_Is_Generate_From_Action__c = true;
        cr.CN_Change_Request_Status__c = 'Approved';
        insert cr;

        Test.startTest();
        CN_CR_Send_To_SAP_LC_Ctrl.getCRInfoAndCheckEditPermisison(cr.Id);
        Test.setMock(HTTPCalloutMock.class, new TestHttpMock());
        CN_CR_Send_To_SAP_LC_Ctrl.sendCR(cr.Id);
        Test.stopTest();
    }
    @isTest
    private static void controllerTest_404() {
        TestDataFactory testDataFactory = new TestDataFactory();

        List<User> userList = [SELECT Id, LastName FROM User];
        Map<String, Id> lastNameUserIdMap = new Map<String, Id>();
        for(User usr: userList) {
            lastNameUserIdMap.put(usr.LastName, usr.Id);
        }

        Talend_Setting__c talendSetting = new Talend_Setting__c();
        talendSetting.Change_Request_Endpoint__c = 'http://127.0.0.1/CR/404';
        talendSetting.Password__c = 'password';
        talendSetting.Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/404';
        talendSetting.Sanbox_Change_Request_Endpoint__c = 'http://127.0.0.1/CR/404';
        talendSetting.Sanbox_Sales_Order_Update_Endpoint__c = 'http://127.0.0.1/SO/404';
        talendSetting.Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Customer_Hierarchy_Endpoint__c = 'http://127.0.0.1/CH/404';
        talendSetting.Sandbox_Password__c = 'password';
        talendSetting.Sandbox_Send_To_Account_Endpoint__c = 'http://127.0.0.1/ACC/404';
        talendSetting.Sandbox_User_Name__c = 'Name';
        talendSetting.Send_to_Account_Endpoint__c = 'http://127.0.0.1/ACC/404';
        talendSetting.User_Name__c = 'Name';
        talendSetting.Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        talendSetting.Sandbox_Quote_Endpoint__c = 'http://127.0.0.1/Quote/200';
        insert talendSetting;

        Account acc = testDataFactory.makeAccounts(1,false)[0];
        User salesRep = [SELECT Id FROM User WHERE lastName = 'Sales1'][0];

        Id newContactRTId = Schema.SObjectType.CN_Change_Request__c.getRecordTypeInfosByDeveloperName().get(Constants.CN_CR_RT_API_NAME_NEW_CONTACT).getRecordTypeId();
        CN_Change_Request__c cr = new CN_Change_Request__c();
        cr.RecordTypeId = newContactRTId;
        cr.New_CN_Contact_Type__c = '04';
        cr.New_CN_Contact_License_Name__c = acc.Id;
        cr.New_CN_Contact_Title__c = 'CR Contact Title';
        cr.New_CN_Contact_Dept_Of_Contact_Person__c = '0002';
        cr.New_CN_Contact_CN_First_Name__c = 'Contact 01';
        cr.New_CN_Contact_CN_Last_Name__c = 'Test CR';
        cr.New_CN_Contact_Name_EN__c = 'Test CR Contact Name 01';
        cr.New_CN_Contact_Mobile__c = '15755555551';
        cr.New_CN_Contact_Billing_To_Address__c = 'CR Bill to Address';
        cr.CN_Is_Generate_From_Action__c = true;
        cr.CN_Change_Request_Status__c = 'Approved';
        insert cr;

        Test.startTest();
        CN_CR_Send_To_SAP_LC_Ctrl.getCRInfoAndCheckEditPermisison(cr.Id);
        Test.setMock(HTTPCalloutMock.class, new TestHttpMock());
        CN_CR_Send_To_SAP_LC_Ctrl.sendCR(cr.Id);
        Test.stopTest();
    }
}