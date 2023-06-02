# Waypath Technical Assesment
There are a few gaps and bugs that I will be continuing to fix, but this is what I came up with in a reasonable amount of time. I will create a seperate Repo so that I can continue to build this out and make the desired improvements. 

## Known issues

The Component does not handle multiple contacts. I haven't dug into why, yet. 

The way I am creating the Account/contact Relationship is through the AccountContachRelation sObject, which is different than the regular relationship. I know there is a way to create that relationship by serializing the record into JSON and then adding the relationship, then deSerializing the JSON into the sObjectType. In order for the current method to work, the Account Setting "Allow users to relate a contact to multiple accounts" must be enabled, and the contact must have a primary Account. Additionally some page layout changes are needed to show the relationship. 

## Areas to improve
I would like the components to be more abstracted from the Contact sobject, That way this search functionality could be reuseable. You can see I was trying to accomplish this, but quickly realized it was taking too much time.

I want to fix the issue with the LWC to handle multiple contact updates 

I would like to include jest tests

I need to impove the test data creation and expand on the current Apex tests. 



