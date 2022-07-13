public class CustomErrorException extends Exception{

    public String errorCode;
    public String message;
    public CustomErrorException(String errorCode, string message){
        this.errorCode = errorCode;
        this.message = message;
    }
}