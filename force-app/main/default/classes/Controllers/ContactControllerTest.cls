/**
 * @author Rob Shircliff
 * @date 6/2/2023
 * 
 * @description Test Class for Contact Controller
 */
@IsTest
public with sharing class ContactControllerTest {

    public static Integer numOfContacts = 5;

    @TestSetup
    static void createContacts() {
        Account acc = new Account(name = 'Test Account');
        insert acc;
        Map<String, String> names = new Map<String, String>();
        names.put('first', 'last');
        names.put('second', 'Testerson');

        for (String firstName : names.keySet()) {
            ContactFactory.createContacts(numOfContacts, firstName, names.get(firstName));  
        }
    }

    @IsTest
    private static void givenSearchKeyTestWhenFetchContactsReturnRelatedContacts() {
        String searchKey = 'test';
        List<Contact> contactsFound = ContactController.fetchContacts(searchKey);

        //confirm returned list does not contain any contacts with the name of First Last
        //TODO: Find a more dymanic a scalable way to assert this without hardcoding string values
        for (Contact con : contactsFound) {
            System.assert(con.Name.contains('second'));
            System.assert(!con.Name.contains('first'));         
        }

        System.assertEquals(numOfContacts, contactsFound.size(), 'The number of returned contacts did not match the number created');
    }

    @IsTest
    private static void givenSearchKeyFirWhenFetchContactsReturnRelatedContacts() {
        String searchKey = 'fir';
        List<Contact> contactsFound = ContactController.fetchContacts(searchKey);
        
        //confirm returned list does not contain any contacts with the name of Last Testerson
        //TODO: Find a more dymanic a scalable way to assert this without hardcoding string values
        for (Contact con : contactsFound) {
            System.assert(con.Name.contains('first'));
            System.assert(!con.Name.contains('second'));
        }

        System.assertEquals(numOfContacts, contactsFound.size(), 'The number of returned contacts did not match the number created');
    }

    //TODO: Write tests for updating contacts 

}