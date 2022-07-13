global class MDT_ObjectWrapper{
       @AuraEnabled
       global String homecountry;
       @AuraEnabled
       global String product;
       @AuraEnabled
       global Cost_per_Calendar_Month__mdt cost_calmonth;
       @AuraEnabled
       global Card_Replacement_Cost__mdt cardreplace_cost;
       @AuraEnabled
       global ATM_Fee_in_other_currencies__mdt atm_fee;
     

     global MDT_ObjectWrapper(String homecountry,String product,Cost_per_Calendar_Month__mdt cost_calmonth,Card_Replacement_Cost__mdt cardreplace_cost,ATM_Fee_in_other_currencies__mdt atm_fee){
         this.homecountry=homecountry;
         this.product=product;
         this.cost_calmonth=cost_calmonth;
         this.cardreplace_cost=cardreplace_cost;
         this.atm_fee=atm_fee;
        }  
    }