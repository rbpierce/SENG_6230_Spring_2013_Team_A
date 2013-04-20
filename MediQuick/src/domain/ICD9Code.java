package domain;

import java.util.ArrayList;

import dao.ICD9CodeRepository;

public class ICD9Code extends ICD9CodeRepository {

    public static ArrayList<ICD9Code> getCodes() {
        ArrayList<ICD9Code> List =  ICD9CodeRepository.getList();
        return List;
    }

}
