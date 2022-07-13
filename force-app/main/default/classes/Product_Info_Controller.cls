/*
Author: Nishant Mohan Wavhal
Created Date: 7/11/2022
Apex Class to give Product Info to LWC
*/

public with sharing class Product_Info_Controller {

    /* Method: cost_per_Calendar_Month 
    method returns specidic mdt specific to cost_per_Calendar_Month
    */
    @AuraEnabled
    public static List<MDT_ObjectWrapper> cost_per_Services(Id caseId){
       List<MDT_ObjectWrapper> mdtwrapperList =new List<MDT_ObjectWrapper>();
       MDT_ObjectWrapper mdtwrapper;
       Cost_per_Calendar_Month__mdt cp;
       Card_Replacement_Cost__mdt cr;
       ATM_Fee_in_other_currencies__mdt a;
        
        String homecountry;
        String product;
        
        if(caseId !=null)
        {
            Case c = [select id ,ContactId,contact.home_Country__c,contact.Product__c from Case where id =:caseId limit 1];
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
              throw new AuraHandledException('Contact Value has an Error, Product/HomeCountry not mentioned'); 
           }
            else
                throw new AuraHandledException('Contact Value is Null'); 
        }
            
        }
        if(cp!=null && cr!=null && a!=null)
        {
       	mdtwrapper= new MDT_ObjectWrapper(homecountry,product,cp,cr,a);
        mdtwrapperList.add(mdtwrapper);
        }

           
       return mdtwrapperList; 
        
        
    }
  

}