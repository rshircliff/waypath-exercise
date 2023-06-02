public with sharing class ContactController {      
    @AuraEnabled( cacheable = true )  
    public static List<Contact> fetchContacts( String searchKey ) {  
        System.debug('here is the string: ' + searchKey);
        String strKey = '%' + searchKey + '%';  
        return [
            SELECT Id, Name
            FROM Contact
            WHERE AccountId != NULL 
            AND Name LIKE: strKey LIMIT 5
        ];  
    }    

    @AuraEnabled
    public static string updateContactsAccount(Id accountId, List<Contact> contacts) {
        //This will only work if the contact has a primary account. 
        List<AccountContactRelation> accConRels = new List<AccountContactRelation>();
        
        try {
            for (Contact con : contacts) {
                AccountContactRelation acr = new AccountContactRelation();
                acr.AccountId = accountId;
                acr.ContactId = con.Id;      
                accConRels.add(acr);     
            }
            Database.insert(accConRels);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        //find better return value
        return 'ok';
    }
}