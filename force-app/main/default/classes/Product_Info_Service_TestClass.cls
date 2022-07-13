@isTest
public class Product_Info_Service_TestClass {
    @TestSetup
    public static void productservicetestsetup()
    {
        Contact c=  new Contact();
        c.Firstname='Test 1';
        c.lastname='Test 1';
        c.Home_Country__c='DE';
        c.product__c='Metal';
       
        
        Contact c1=  new Contact();
        c1.firstname='Test 2';
        c1.lastname='Test 2';
        c1.Home_Country__c='';
        c1.product__c='Metal';
        
       List<Contact> cList =new List<Contact>();
        cList.add(c);
        cList.add(c1);
        
        insert cList;
        
      Case cs= new Case();
      cs.Origin='Email';
      cs.contactid=cList[0].id;
        
      Case cs1= new Case();
      cs1.Origin='Email';
      cs1.contactid=cList[1].id;
        
      Case cs2= new Case();
      cs2.Origin='Email';
        
      List<Case> csList = new List<Case>();
       csList.add(cs);
       csList.add(cs1);
       csList.add(cs2);
        
        insert csList;
    }
  @isTest  
 public static void getProductinfoUUIDtest() {
        Contact c =[select id,uuid__c from Contact limit 1];
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInfoService/'+c.uuid__c; 
        req.httpMethod = 'GET';

        
        RestContext.request = req;
        RestContext.response= res;

        Test.startTest();
        Product_Info_Service.N26_method();
        Test.stopTest();
 Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(RestContext.response.responsebody.toString());
 System.assertEquals(200, RestContext.response.statusCode,'Success');    
 System.assertEquals('Metal', m.get('product'),'Should be metal');
 System.assertEquals('DE', m.get('homecountry'),'Should be Germany');
 Map<String,Object> m1= (Map<String,Object>)m.get('cost_calmonth');
 Map<String,Object> m2=(Map<String,Object>)m.get('cardreplace_cost');
 Map<String,Object> m3=(Map<String,Object>)m.get('atm_fee');
 System.assertEquals(16.9, m1.get('Cost__c'),'Should be 16.9');    
 System.assertEquals(45,m2.get('Cost__c'),'Should be 45');
 System.assertEquals(0, m3.get('Cost__c'),'Should be 0');  
}

    @isTest
 public static void getProductinfoUUIDtest1() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInfoService/123'; 
        req.httpMethod = 'GET';
     
        RestContext.request = req;
        RestContext.response= res;

        Test.startTest();
        Product_Info_Service.N26_method();
        Test.stopTest();
     
    System.assertEquals(500, RestContext.response.statusCode,'error'); 
}
    
  @isTest  
 public static void getProductinfoUUIDtest2() {
        Contact c =[select id,uuid__c from Contact where lastname='Test 2' limit 1];
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInfoService/'+c.uuid__c; 
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response= res;

        Test.startTest();
        Product_Info_Service.N26_method();
        Test.stopTest();
     
     System.assertEquals(500, RestContext.response.statusCode,'error'); 
}
    
    @isTest
    public static void getProductinfoUUIDtest3() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInfoService/'; 
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response= res;

        Test.startTest();
        Product_Info_Service.N26_method();
        Test.stopTest();
     
     System.assertEquals(500, RestContext.response.statusCode,'error'); 
}

}