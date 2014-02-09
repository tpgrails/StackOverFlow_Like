package fr.isima


class User {
	String email
	String password
	String name
	Date birthday
	Badge badge
	int point=0
	
	static constraints = {
		badge nullable:true
	  }
	
	
	User(){
		
	}
	public void create(User user){
		user.save()
	}
}