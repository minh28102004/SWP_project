/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.error_report;

/**
 *
 * @author HP
 */
public class RegisterError {
    private String confirmNotMatch = "";
    private String accountExist = "";
    public boolean checkConfirmMatch(String password, String confirm){
        if(password.trim().equals(confirm.trim())){
            confirmNotMatch ="";
            return true;
        }else{
            confirmNotMatch ="password and confirm password do not match";
            return false;
        }
    }

    public String getConfirmNotMatch() {
        return confirmNotMatch;
    }

    public void setConfirmNotMatch(String confirmNotMatch) {
        this.confirmNotMatch = confirmNotMatch;
    }

    public String getAccountExist() {
        return accountExist;
    }

    public void setAccountExist(String accountExist) {
        this.accountExist = accountExist;
    }
}
