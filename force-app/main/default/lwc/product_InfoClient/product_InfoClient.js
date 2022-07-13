/*
Author: Nishant Mohan Wavhal
Created Date: 7/11/2022
Lightning Web Component for Product Info
*/
import { LightningElement,wire,api,track } from 'lwc';
import getCostPerService from '@salesforce/apex/Product_Info_Controller.cost_per_Services';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Product_InfoClient extends LightningElement{
@api recordId;
@track mdtwrap=[];
@track error;

    connectedCallback()
    {
      this.handleLoad();
    }

    handleLoad() 
    {
        getCostPerService({caseId:this.recordId})
            .then(result => {
                this.mdtwrap=result;
            })
            .catch(error => {
                this.error = error;
                console.log('Error',this.error);
                this.dispatchEvent(
                new ShowToastEvent({
                title: "Error",
                message:this.error.body.message,
                variant: "Error",
            }),
          );    
        });
    }
}