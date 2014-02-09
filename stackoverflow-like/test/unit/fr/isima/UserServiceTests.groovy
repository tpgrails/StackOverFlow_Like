package fr.isima



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(UserService)
class UserServiceTests {

    void testSomething() {
       User user = new User()
	   user.name ="test"
	   user.email="test@test.ts"
	   user.password = "aaaa"
	   
	   user.save()
	   UserService.verificationReputation(user.id, 0)
	   assertEquals(user.badge.currentTitle,Badge.Badge.title.get(0))
	   
    }
}
