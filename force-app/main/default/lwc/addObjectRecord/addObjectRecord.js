import { LightningElement, api, track } from 'lwc';
import fetchContacts from '@salesforce/apex/ContactController.fetchContacts';
import updateContactsAccount from '@salesforce/apex/ContactController.updateContactsAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AddObjectRecord extends LightningElement {
    @api objectType;
    @api recordId;

    selectedRecords = [];
    objectRecords; 
    recordsToUpdate = []; 
    error;  
    searchKey;

    handleChange(event) {
      this.searchKey = event.detail.value;
      console.log( 'searchKey is', this.searchKey );

      if (this.searchKey) {  
  
          fetchContacts({searchKey: this.searchKey})    
          .then(result => {           
              this.objectRecords = result;
          } )  
          .catch(error => {  
              console.log( 'Error Occured', JSON.stringify(error) );
              this.error = error;  
  
          } );  
      } else  {
          this.objectRecords = null;  
      }
  }

  handleSelect(event) {
      let strIndex = event.currentTarget.dataset.id;
     
      console.log('strIndex is', strIndex);
      // is this necessary?
      let tempRecs = JSON.parse(JSON.stringify(this.objectRecords));
      let selectedRecId = tempRecs[strIndex].Id;
      console.log( 'Record Id is', selectedRecId );
      let strAccName = tempRecs[strIndex].Name;
      console.log('Name Id is', strAccName);
      this.selectedRecords.push(tempRecs[strIndex]);
      console.log('temp Object records: ', this.selectedRecords.length);
      //How to exclude from future search results?
      this.searchKey = null;
      this.objectRecords = null;
  }

  handleCheckbox(event) {
    let strIndex = event.currentTarget.dataset.id;
    let tempRecs = JSON.parse(JSON.stringify(this.selectedRecords));
    console.log('Here is the recordId: ', tempRecs[strIndex].Id);
    let recordToUpdate = this.selectedRecords[strIndex];
    if (!this.recordsToUpdate.includes(recordToUpdate)) {
      this.recordsToUpdate.push(recordToUpdate);
    } else {
      //do not like this, find better way to remove from array. Likely filter();
      delete this.recordsToUpdate[strIndex];
    }

    console.log('Records to Update: ', JSON.stringify(this.recordsToUpdate));
  }

  handleClick(event) {
    console.log('this is the account id: ', this.recordId);
    updateContactsAccount({accountId: this.recordId, contacts: this.recordsToUpdate}).then(result => { 
      //const toastEvent = new ShowToastEvent();
      console.log('here is the callback result: ', result);
      if (result === 'ok') {
        const event = new ShowToastEvent({
          title: 'Update Complete',
          message: 'Contacts added to Account!',
          variant: 'success',
          mode: 'dismissable'
      });
      this.dispatchEvent(event);
      this.selectedRecords = null;
      } else {
        console.log('in else')
      }
      //this.dispatchEvent(toastEvent);
    });
  }
  
  get showSelectedRecords() {
    return this.selectedRecords?.length > 0;
  }

  get showResults() {
    return this.objectRecords?.length > 0;
  }

  

  get cardTitle() {
    return "Add " + this.objectType;
    }
    // get objectList() {
    //   return this.objectRecords;
    // }

}