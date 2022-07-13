@isTest
public class Product_Info_Controller_TestClass {
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
 public static void getProductinfoUUIDtest1() {
       Case c =[select id from Case limit 1];

        Test.startTest();
         List<MDT_ObjectWrapper> mwrap=Product_Info_Controller.cost_per_Services(c.id);
        Test.stopTest();
 
}

  @isTest  
 public static void getProductinfoUUIDtest2() {
       List<Case> cList =[select id from Case];

        Test.startTest();
         List<MDT_ObjectWrapper> mwrap=Product_Info_Controller.cost_per_Services(cList[1].id);
        Test.stopTest();
 
}
    

  @isTest  
 public static void getProductinfoUUIDtest3() {
       List<Case> cList =[select id from Case];

        Test.startTest();
         List<MDT_ObjectWrapper> mwrap=Product_Info_Controller.cost_per_Services(cList[2].id);
        Test.stopTest();
 
}
    
  @isTest  
 public static void getProductinfoUUIDtest4() {
        Test.startTest();
         List<MDT_ObjectWrapper> mwrap=Product_Info_Controller.cost_per_Services('5007Q00000C3Ta9QAF');
        Test.stopTest();
 
}
}