package fr.isima

class Message {

	User sender
	String content
	
	static constraints = {
		content type:'text'
		content(maxSize:2000)
		
	  }
}
