package fr.isima

class Answer {

	String content
	boolean validated
	int votes
	User user
	Question question
	
	static hasMany = [usersVote: User]
	
	
	static constraints = {
		content type:'text'
		content(maxSize:2000)
		
	  }
	
	
	Answer(String content,User user, Question question){
		
		this.content = content
		this.user = user
		this.question = question
		this.votes = 0
		this.validated = false;
		
				
	}
}
