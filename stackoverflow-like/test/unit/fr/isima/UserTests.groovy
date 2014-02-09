package fr.isima



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(User)
class UserTests {

    void testSomething() {
       User user = new User()
	   user.point = 1000
	   UserService.verificationReputation(0, 0)
    }
}
