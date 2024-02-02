import { LightningElement, track, wire, api } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import {CurrentPageReference} from 'lightning/navigation';
import getRelatedList  from '@salesforce/apex/CN_Competitor_Price_Controller.getRelatedPrice';

import title from '@salesforce/label/c.CN_Competitor_Product_Price_Title';
import channelLabel from '@salesforce/label/c.CN_Competitor_Product_Price_Channel_Label';
import priceLabel from '@salesforce/label/c.CN_Competitor_Product_Price_Price_Label';



export default class LightingWebComponentContactList extends LightningElement {

    @api recordId;

    @track columns =  [
        {label:channelLabel, fieldName:'Channel' }
        ,{label:priceLabel, fieldName:'Price' }
    ];

    @track contactList;

    @api title = title;

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        const domain = document.domain;
        console.log(domain)

        if (currentPageReference) {
            console.log(JSON.stringify(currentPageReference));
            console.log(currentPageReference.attributes.recordId)
            this.recordId = currentPageReference.attributes.recordId

            getRelatedList({
                recordId:currentPageReference.attributes.recordId
            }).then((result) => {
                console.log(result);
                this.contactList = JSON.parse(result);
            });
        }
    }


    @track isShowModal = false;

    showToast(title,message,varient,mode) {
        const event = new ShowToastEvent({
            title   : title
            ,message : message
            ,variant : varient //info/success/warning/error
            ,mode    : mode    //sticky
            //pester
            //dismissable sticky+pester
        });
        this.dispatchEvent(event);
    }
}