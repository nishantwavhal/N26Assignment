/*
Author: Nishant Mohan Wavhal
Created Date: 7/11/2022
Apex Class to give Product Info to LWC
*/

public with sharing class Product_Info_Controller {
    
  @AuraEnabled
  public static List<MDT_ObjectWrapper> cost_per_Services(Id caseId){
      List<MDT_ObjectWrapper> mdtwrapperList =new List<MDT_ObjectWrapper>();
      MDT_ObjectWrapper mdtwrapper;
      Cost_per_Calendar_Month__mdt cost_per_cal_mon;
      Card_Replacement_Cost__mdt card_replace_cost;
      ATM_Fee_in_other_currencies__mdt atm_fee;
      
      String homecountry;
      String product;
      
      if(caseId !=null)
      {
          Case cs = [select id ,ContactId,contact.home_Country__c,contact.Product__c from Case where id =:caseId limit 1];
          if(cs!=null)
          { 
              if(cs.ContactId!=null)
              {
                  if(cs.contact.home_Country__c!=null && cs.contact.product__c!=null && cs.contact.home_Country__c!='' && cs.contact.product__c!='')
                  {
                      cost_per_cal_mon=Product_Info_Service.costpermonthservice(cs.contact.home_Country__c,cs.contact.product__c);
                      
                      card_replace_cost= Product_Info_Service.cardreplacementservice(cs.contact.home_Country__c,cs.contact.product__c);
                      
                      atm_fee=Product_Info_Service.atmfeeservice(cs.contact.home_Country__c,cs.contact.product__c);           
                      
                      homeCountry=cs.contact.home_Country__c;
                      product=cs.contact.product__c;
                  }
                  else
                      throw new AuraHandledException('Contact Value has an Error, Product/HomeCountry not mentioned'); 
              }
              else
                  throw new AuraHandledException('Contact Value is Null'); 
          }
          
      }
      if(cost_per_cal_mon!=null && card_replace_cost!=null && atm_fee!=null)
      {
          mdtwrapper= new MDT_ObjectWrapper(homecountry,product,cost_per_cal_mon,card_replace_cost,atm_fee);
          mdtwrapperList.add(mdtwrapper);
      }        
      return mdtwrapperList;         
  }    
}