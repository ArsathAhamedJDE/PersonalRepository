@isTest
public class AccountHandlerTest {
    
    /* 
    * This SetUpdata Method creates the User and Insert Account
    */
    @TestSetup
    static void setUpData(){
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User usr = new User(LastName = 'Ahamed',
                            FirstName='Arsath',
                            Alias = 'AAham',
                            Email = 'Arsath.Ahamed@gmail.com',
                            Username = 'Arsath.Arsath.user@gmail.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        List<Account> AccList = new List<Account>();
        for(integer i = 0; i <100 ; i++){
            Account Acc = New Account();
            Acc.Name ='Test Account'+ i; 
            Acc.AnnualRevenue = 100;
            AccList.add(Acc);
        }
        
        insert AccList;
        
    }
    
    /* 
    * This method Creates the Account record and invokes the Insert Trigger 
    */
    static testmethod void createAccount(){ 
        User U = [SELECT Id,Name FROM User LIMIT 1];
        System.debug('user-->'+ U.Name);
        System.runAs(u){
            Test.startTest();
            List<Account> AccList = new List<Account>();
            for(integer i = 0; i <100 ; i++){
                Account Acc = New Account();
                Acc.Name ='Test Account'+ i; 
                Acc.AnnualRevenue = 100;
                AccList.add(Acc);
            }
            
            insert AccList;
            Test.stopTest();
            
            Account Accnt = [SELECT ID, Name , AnnualRevenue FROM Account LIMIT 1];
            System.assertEquals(100, Accnt.AnnualRevenue);
        }      
    }
    
    /* 
    * This method Creates the Account record and invokes the Update Trigger 
    */
    static testmethod void updateAccount(){ 
     User U = [SELECT Id,Name FROM User LIMIT 1];
        System.debug('user-->'+ U.Name);
        System.runAs(u){
            Test.startTest();
            List<Account> AccList = [SELECT Id, Name, AnnualRevenue FROM Account LIMIT 10];
            Account Acc = new Account();
            Acc.ParentId = AccList[0].Id;
            Acc.AnnualRevenue = 150;
            Acc.Id = AccList[1].Id;
            Update Acc;
            Test.stopTest();
            
            System.debug('');
            Account Accnt = [SELECT Id, Name , AnnualRevenue FROM Account LIMIT 1];
            System.assertEquals(150, Accnt.AnnualRevenue);
        }
    }
}