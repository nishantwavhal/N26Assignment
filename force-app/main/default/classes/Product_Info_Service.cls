/*
Author: Nishant Mohan Wavhal
Created Date: 7/11/2022
Apex Class to Call API Services
*/
@RestResource(urlMapping='/ProductInfoService/*')
global class Product_Info_Service {   

 @HttpGET
 global static void N26_method() {
 
     RestRequest req = RestContext.request;
     RestResponse res =RestContext.response;
     
     String contactUUID= req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
	 
     MDT_ObjectWrapper mdtwrapper=null;
     
     Cost_per_Calendar_Month__mdt cost_calmonth= null;
     Card_Replacement_Cost__mdt cardreplace_cost = null;
     ATM_Fee_in_other_currencies__mdt atm_fee = null;
        
     String homecountry;
     String product;
        
        if(contactUUID !=null && contactUUID !='')
        {  
            Contact c;
            try
				{
				   c=[select id ,home_Country__c,Product__c from Contact where uuid__c =:contactUUID limit 1];
				}
			catch(Exception e)
				{            
				   res.responseBody=Blob.valueOf(e.getmessage());               	
				}
            
            
            if(c!=null)
           {
            if(c.home_Country__c!=null && c.product__c!=null && c.home_Country__c!='' && c.product__c!='')
            {
			 cost_calmonth= costpermonthservice(c.home_Country__c, c.product__c);

             cardreplace_cost= cardreplacementservice(c.home_Country__c, c.product__c);

             atm_fee=atmfeeservice(c.home_Country__c, c.product__c);           
			   
             homeCountry=c.home_Country__c;
                
             product=c.product__c;
            }
            else
            {
               res.responseBody=Blob.valueOf(JSON.serialize(new CustomErrorException('500','Contact Value has an Error')));
            }
           }
                
        }
     	else
        {		
			
             res.ResponseBody =Blob.valueOf(JSON.serialize(new CustomErrorException('500','Please Enter Contact UUID')));
		}
     
        if(cost_calmonth!=null && cardreplace_cost!=null && atm_fee!=null &&  homeCountry!=null &&  product!=null)
        {           
        mdtwrapper= new MDT_ObjectWrapper(homecountry,product,cost_calmonth,cardreplace_cost,atm_fee);
        res.statusCode=200; 
        res.ResponseBody =Blob.valueOf(JSON.serialize(mdtwrapper));
        }
        else
        {
           res.statusCode=500; 
        }

    } 

    public static Cost_per_Calendar_Month__mdt costpermonthservice(String homecountry,String product)
{ 
    try
    {
        return [select id,Cost__c from Cost_per_Calendar_Month__mdt where home_Country__c=:homecountry and product__c=:Product limit 1 ];
    }
    Catch(Exception e)
    {
        throw e;
    }
}

 public static Card_Replacement_Cost__mdt cardreplacementservice(String homecountry,String product)
{
    try{
     return  [select id,Cost__c from 	Card_Replacement_Cost__mdt where home_Country__c=:homecountry and product__c=:Product limit 1 ];  
    }
    catch(Exception e)
    {
        throw e;
    }
}
    
public static ATM_Fee_in_other_currencies__mdt atmfeeservice(String homecountry,String product)
{
  try
  {
      return [select id,Cost__c from ATM_Fee_in_other_currencies__mdt where home_Country__c=:homecountry and product__c=:Product limit 1 ];  
  }
  catch(Exception e)
    {
        throw e;
    }
}
}