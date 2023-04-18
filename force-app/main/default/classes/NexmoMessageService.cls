public class NexmoMessageService implements IMessageService {

    public MessageServiceBase.MessageResponse sendSMS(MessageServiceBase.MessageRequest request)
    {
        String api_key = '00DE0X0A0M0PeLE!AQcAQH0dMHEXAMPLEzmpkb58urFRkgeBGsxL_QJWwYMfAbUeeG7c1EXAMPLEDUkWe6H34r1AAwOR8B8fLEz6nEXAMPLE';  
        String api_secret= '6303@Jio#';
        string fromNumber=request.fromNumber;
        string toNumber=request.toNumber;
        string message=request.message;
        
        MessageServiceBase.MessageResponse response=new MessageServiceBase.MessageResponse();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://rest.nexmo.com/sms/json');
        req.setMethod('POST'); 
        req.setHeader('Content-Type','application/json');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        if(string.isNotBlank(fromNumber) && string.isNotBlank(toNumber) && string.isNotBlank(message))
        {
            string jsonString='from='+EncodingUtil.urlEncode(fromNumber, 'UTF-8')+'&text='+EncodingUtil.urlEncode(message, 'UTF-8')+
                '&to='+EncodingUtil.urlEncode(toNumber, 'UTF-8')
                +'&api_key='+EncodingUtil.urlEncode(api_key, 'UTF-8')+'&api_secret='+EncodingUtil.urlEncode(api_secret, 'UTF-8')+'';
            req.setBody(jsonString);
            system.debug('jsonString:'+jsonString);
            try{
                Http http = new Http();
                HTTPResponse res = http.send(req);
                
                if(res.getStatusCode()==200)
                {
                    system.debug('SMS Sent to '+toNumber);
                    response.status='SUCCESS';
                }
                else{
                    system.debug('SMS Failed to sent :'+toNumber);
                    response.status='FAILED';
                }
                system.debug(res.getBody());
                response.message=res.getBody();
            }
            catch(Exception e){
                response.status='ERROR';
                response.message=e.getMessage();
            } 
        }
        else
        {
             response.status='ERROR';
             response.message='Invalid parameter entered';
        }
        return response;
    }
}