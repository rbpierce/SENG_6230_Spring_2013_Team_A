package test.dao;

import dao.PersonRepository;
import domain.Person;
import junit.framework.TestCase;


public class PatientTest extends TestCase {

	private Person person;
	
	public final void testGetById() {
		person = PersonRepository.getById(1);
		assertNotNull("Person with id 1 should exist", person);
	}

	public final void testGetUpdatePerson() {
		person = PersonRepository.getPerson("john", "smith");
		assertNotNull("username/password john/smith should retrieve employee id 1", person);
		assertEquals("username/password john/smith should retrieve employee id 1", 1, person.getId());
		
		assertEquals("Employee should have first name John", "John", person.getFirstName());
		person.setFirstName("Jacob");
		PersonRepository.updatePerson(person);
		person = PersonRepository.getById(1);
		assertEquals("Employee should have first name Jacob", "Jacob", person.getFirstName());
		person.setFirstName("John");
		PersonRepository.updatePerson(person);
	}



}
