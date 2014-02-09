package fr.isima





class Question {
	String title
	String content
	int votes
	User user
	int view
	Date dateCreation
	
	
	
	static hasMany = [answers: Answer,usersVote: User]
	
		static mapping = {
			answers cascade: 'all-delete-orphan'
		}
	
	Question(){
		
	}
	
	Question(String title,String content,User user){
		this.title = title
		this.content = content
		this.user = user
		this.dateCreation = new Date()
		this.votes = 0
		this.view = 0
		
	}
	
	
	static constraints = {
		// size of content of the question to avoid problems with size in the database
		content type:'text'
		content(maxSize:2000)
		title nullable:true
		content nullable:true
		votes nullable:true
		view nullable:true
		dateCreation nullable:true
		user nullable:true
		answers nullable:true
	  }
}
