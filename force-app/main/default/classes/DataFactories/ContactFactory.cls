/**
 * @author Rob Shircliff
 * @date 6/2/2023
 * 
 * @description DataFactory for Contacts
 */
@IsTest
public class ContactFactory {
  
    public static void createContacts(Integer numOfContacts, String firstName, String lastName) {
      Account acc = [SELECT ID from Account Limit 1][0];
      if (acc == null) { 
        throw new ContactControllerException('No Account Found');
      }
        List<Contact> contactsToAdd = new List<Contact>();
        for (Integer i = 0; i < numOfContacts; i++) {
          Contact con = new Contact(FirstName = firstName,
                                    LastName = lastName + String.valueOf(i+1),
                                    AccountId = acc.Id
                                  );
          contactsToAdd.add(con);
        }
        try {
          insert contactsToAdd;
        } catch (Exception e) {
          system.debug(e.getMessage());
        }      
    }
    
  }