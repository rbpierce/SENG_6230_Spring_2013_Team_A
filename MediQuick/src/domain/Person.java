package domain;

import dao.PersonRepository;

public class Person extends PersonRepository {

    public boolean hasPermission(String _permission) {
        return this.getRole().getPermissions().contains(_permission);
    }

}
