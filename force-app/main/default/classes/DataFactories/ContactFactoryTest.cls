/**
 * @author Rob Shircliff
 * @date 6/2/2023
 * 
 * @description Test Class for Data Factory
 */
@IsTest
public with sharing class ContactFactoryTest {
   
   @IsTest
   static void givenIntegerWhenCreateContactsThenContactsCreated() {
    Integer numContacts = 5;
    ContactFactory.createContacts(numContacts, 'first', 'last');
    assertNumberOfContactsCreated(numContacts);   
   }

   @IsTest
   static void givenZeroWhenCreateContactsThenContactsCreated() {
    Integer numContacts = 0;
    ContactFactory.createContacts(numContacts, 'first', 'last');
    assertNumberOfContactsCreated(numContacts);
     
   }

   private static void assertNumberOfContactsCreated(Integer numOfContacts) {
      List<Contact> contactsCreated = [Select Id FROM Contact];
      System.assertEquals(numOfContacts, contactsCreated.size(), 'The number of created contacts did not match the input');   
   }
}