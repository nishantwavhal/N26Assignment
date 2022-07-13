/*
Author: Nishant Mohan Wavhal
Aura Enabled Created Date: 7/11/2022
Custom Error Exception Class
*/

public class CustomErrorException extends Exception{

    public String message;
    public CustomErrorException(String errorCode, string message){
        this.errorCode = errorCode;
        this.message = message;
    }
}