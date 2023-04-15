public class MessageServiceBase {
    
	public virtual class MessageRequest
    {
        public string fromNumber{get;set;}
        public string toNumber{get;set;}
        public string message{get;set;}
    }
    public virtual class MessageResponse
    {
        @AuraEnabled
       	public string status{get;set;}
        @AuraEnabled
        public string message{get;set;}
    }
}