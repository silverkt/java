/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mystruts2.action;

/**
 *
 * @author sillver
 */

  
import com.opensymphony.xwork2.Action;  
  
/**  
 * @author david  
 *  
 */  
public class HelloWorld implements Action {  
  
    private String message;  
      
      
    /**  
     * @return the message  
     */  
    public String getMessage() {  
        return message;  
    }  
  
  
    /* (non-Javadoc)  
     * @see com.opensymphony.xwork2.Action#execute()  
     */  
    @Override  
    public String execute() throws Exception {  
        // TODO Auto-generated method stub  
        message = "Hello World!";  
        return SUCCESS;  
    }  
  
}  