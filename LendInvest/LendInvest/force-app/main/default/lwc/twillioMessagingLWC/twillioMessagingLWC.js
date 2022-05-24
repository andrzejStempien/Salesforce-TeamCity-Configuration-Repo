import { LightningElement, api, wire, track } from 'lwc';
import sendMessage from '@salesforce/apex/LwcController.sendMessage';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ButtonBasic extends LightningElement {
    @track textValue = '';
    @track error;
    @api recordId;

    handleClick(event) {
        sendMessage({ textValue: this.textValue,  recordId: $recordId})
        .then((result) => {
            this.success = result;
            this.error = undefined;
            const event = new ShowToastEvent({
                title: 'Message Sent',
                message: 'New message was sent.',
                variant: 'success'
            });
            this.dispatchEvent(event);
        })
        .catch((error) => {
            const event = new ShowToastEvent({
                title : 'Error',
                message : 'Sending message has failed.',
                variant : 'error'
            });
            this.dispatchEvent(event);
            this.error = error;
            this.success = undefined;

        });
    }

    handleInputChange(event) {
        this.textValue = event.detail.value;
    }
}
