package fr.isima




class UserService {

	/** Add a number of point to the user and update his badge if necessary */
	public static void verificationReputation(long id,int point){
		User user = getUserById(id)
		user.point+=point
		Badge badge = new Badge();
		for (int i = 0; i < badge.title.size(); i++) {
			if(badge.value.get(i) <= user.point){
				badge.currentTitle = badge.title.get(i)
			}
		}
		badge.save()
		user.badge = badge
		
	}
	
	/** Get a user by his email and password */
	public static User getUser(String email,String password){
		
		return User.findByEmailAndPassword(email,password);
	}
	
	/** Get a user by his id */
	public static User getUserById(long id){
		return User.findById(id)
	}
	
	/** Connect a user with his email and password 
	 * @return User if found, otherwise null
	 * 
	 * */
	public static User connect(String email,String password){
		User user = getUser(email, password);
		
		if(user != null){
			return user
		}
		else{
			return null
		}
	}
}
