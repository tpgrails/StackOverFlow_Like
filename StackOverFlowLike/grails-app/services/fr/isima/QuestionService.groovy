package fr.isima

class QuestionService {
	/** Get a question by its id */
	public static Question getQuestion(String id){
		
		return Question.find("from Question as q where q.id = ?",[Long.parseLong(id)]);
	}
	/** Vote on a question */
	public static void vote(String id,int vote,long userid){
		User user = UserService.getUserById(userid);
		Question question = getQuestion(id)
		
		
		boolean alreadyVoted = false
		for(u in question.usersVote){
			if(u.id == userid)
				alreadyVoted = true
		}
		if(!alreadyVoted){
			UserService.verificationReputation(userid,2)
			question.addToUsersVote(user)
			question.votes = question.votes + vote;
			question.save()
		}
		
	}
	/** @return true if the user is the question's owner, otherwise false */
	public static boolean isUserQuestion(long idUser,String idQuestion){
		Question question = getQuestion(idQuestion)
		if(question.user.id.compareTo(idUser) == 0){
			return true;
		}
		return false;
	}
}
