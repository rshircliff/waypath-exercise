public class ContactFactory {
  
    public static void createContacts(Integer numOfContacts) {
      List<Contact> contactsToAdd = new List<Contact>();
      for (Integer i = 0; i < numOfContacts; i++) {
        Contact con = new Contact(FirstName='Joe',
                          LastName='Smith' + String.valueOf(i+1)
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