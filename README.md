# Waypath Technical Assesment
There are a few gaps and bugs that I will continue to fix, but this is what I came up with in a reasonable amount of time.
You will find '//TODO' comments highlighting areas that need to be improved. 

I will be creating a seperate Repo so that I can continue to build this out and make the desired improvements. 

## Known issues

The Component will return Contacts already linked to the account, and errors out when you try to update the contact. 

The way I am creating the Account/contact Relationship is through the AccountContachRelation sObject, which is different than the regular relationship. I know there is a way to create that relationship by serializing the record into JSON and then adding the relationship, then deSerializing the JSON into the sObjectType. 

In order for the current method to work, the Account Setting "Allow users to relate a contact to multiple accounts" must be enabled, and the contact must have a primary Account. Additionally, some page layout changes are needed to show the relationship. 

## Areas to improve
I would like the components to be more abstracted from the Contact sobject, that way this search functionality could be reuseable. You can see I was trying to accomplish this, but quickly realized it was taking too much time.

I want to fix the issue with the LWC to handle multiple contact updates 

I would like to include Jest tests

I need to impove the test data creation and expand on the current Apex tests. 



