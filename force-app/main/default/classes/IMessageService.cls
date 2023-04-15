public interface IMessageService 
{
    MessageServiceBase.MessageResponse sendSMS(MessageServiceBase.MessageRequest request);
}