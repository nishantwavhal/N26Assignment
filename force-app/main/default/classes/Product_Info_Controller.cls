/*
Author: Nishant Mohan Wavhal
Created Date: 7/11/2022
Apex Class to give Product Info to LWC
*/
public with sharing class Product_Info_Controller {

    /* Method: cost_per_Calendar_Month 
    method returns specidic mdt specific to cost_per_Calendar_Month
    */
    @AuraEnabled(cacheable=true)
    public static MDT_ObjectWrapper cost_per_Services(Id caseId){
       MDT_ObjectWrapper mdtwrapper;
       Cost_per_Calendar_Month__mdt cp= new Cost_per_Calendar_Month__mdt();
       Card_Replacement_Cost__mdt cr = new Card_Replacement_Cost__mdt();
       ATM_Fee_in_other_currencies__mdt a = new ATM_Fee_in_other_currencies__mdt();
        
        String homecountry;
        String product;
        
        if(caseId !=null)
        {
            try{
            Case c=[select id ,ContactId,contact.home_Country__c,contact.Product__c from Case where id =:caseId limit 1];
           if(c!=null)
            { 
            if(c.ContactId!=null)
           {
            if(c.contact.home_Country__c!=null && c.contact.product__c!=null && c.contact.home_Country__c!='' && c.contact.product__c!='')
            {
             cp=Product_Info_Service.costpermonthservice(c.contact.home_Country__c,c.contact.product__c);
                        
             cr= Product_Info_Service.cardreplacementservice(c.contact.home_Country__c,c.contact.product__c);
                
             a=Product_Info_Service.atmfeeservice(c.contact.home_Country__c,c.contact.product__c);           
                
              homeCountry=c.contact.home_Country__c;
              product=c.contact.product__c;
            }
              else
              throw new CustomErrorException('500','Contact Value has an Error'); 
           }
            else
                throw new CustomErrorException('500','Contact Value is Null'); 
        }
            
        }
          
         Catch(Exception e)
         {
             System.debug(e.getmessage());
         }
        }
        if(cp!=null && cr!=null && a!=null)
        {
            
        mdtwrapper= new MDT_ObjectWrapper(homecountry,product,cp,cr,a);
        }
        else
           throw new CustomErrorException('500','Something went wrong'); 
        return mdtwrapper;
    }
  

}