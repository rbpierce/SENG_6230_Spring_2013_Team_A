package domain;

public enum MemberType {
	PHYSICIAN("Physician"),
	NURSE("Nurse"),
	PATIENT("Patient"),
	TECHNICIAN("Lab Technician"),
	ADMIN("Administrator");
	
	private String _description;
	private MemberType(String value) {
		this._description = value;
	}
	
	public String getDescription() {
		return this._description;
	}
}
