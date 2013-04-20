package domain;

import java.util.ArrayList;

import dao.LaboratoryRepository;

public class Lab extends LaboratoryRepository{
    public static ArrayList<Lab> getLabs() {
        return LaboratoryRepository.getList();
    }

}
