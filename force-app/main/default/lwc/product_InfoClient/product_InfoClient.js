import { LightningElement,wire,api,track } from 'lwc';
import getCostPerService from '@salesforce/apex/Product_Info_Controller.cost_per_Services';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';



export default class Product_InfoClient extends LightningElement {
    @api recordId;
    @track mdtwrap=[];
    @track error;
 
   


    connectedCallback() {

        console.log("recordId", this.recordId);
        this.handleLoad();
    }
 

    handleLoad() {
    getCostPerService({caseId:this.recordId}).then(result => {
        try{
             this.mdtwrap=result;
             //console.log("Hello world ", JSON.stringify(this.mdtwrap));
        }catch( e)
        {     
       console.error('Error',e);
        }
    
  
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