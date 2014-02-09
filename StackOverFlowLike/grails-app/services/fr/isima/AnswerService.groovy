package fr.isima

class AnswerService {
	
	/** List all the answers of a question by its id */
	public static List<Answer> getAnswers(long id){
		
		//return Answer.findAllByQuestion(Question.get(id));
		return Answer.findAll("from Answer as a where a.question.id = ?",[id]);
	}
	
	/** List all the answers of a question by its id 
	 * The list is sorted by the number of votes
	 *  the validates answer is on top of the list */
	public static List<Answer> getAnswersSorted(long id){
		//ArrayList<Answer> answers = Answer.findAllByQuestion(Question.get(id),[sort: "votes", order: "desc"]);
		ArrayList<Answer> answers = Answer.findAll("from Answer as a where a.question.id = ? order by a.votes DESC",[id]);
		def valide
		for (int i = 0; i < answers.size(); i++) {
			if(answers.get(i).validated){
				valide = answers.remove(i)
				answers.add(0, valide)
			}
		}
		
		return answers;
	}
	
	/** Get an answer by its id*/
	public static Answer getAnswer(String id){
		return Answer.findById(id);
	}
	
	/** Vote on an answer
	 * A user who's already voted on a particular answer, can't vote on it a second time
	 *  */
	public static void vote(String id,int vote,long userid){
		User user = UserService.getUserById(userid);
		Answer answer = getAnswer(id)
		boolean alreadyVoted = false
		for(u in answer.usersVote){
			if(u.id == userid)
				alreadyVoted = true
		}
		if(!alreadyVoted){
			UserService.verificationReputation(userid,2)
			answer.addToUsersVote(user)
			answer.votes = answer.votes + vote;
			answer.save()
		}
		
	}
	/** Checks if the user owns the answer
	 * @return true if the user is the one who posted the answer, false if not
	 * */
	public static boolean isUserAnswer(long idUser,String idAnswer){
		Answer answer = getAnswer(idAnswer)
		if(answer.user.id.compareTo(idUser) == 0){
			return true;
		}
		return false;
	}
	
	/** Validate ( approve of) an answer
	 * It can only be done by the user who posted the question
	 * */
	public static void validate(String id){
		Answer answer = getAnswer(id)
		UserService.verificationReputation(answer.user.id,50)
		answer.validated =true;
	}
	
	/** Checks if the answer was validated */
	public static boolean isValidated(long idQuestion){
		ArrayList<Answer> answers = getAnswers(idQuestion)
		for (int i = 0; i < answers.size(); i++) {
			if(answers.get(i).validated == true)
				return true
			
		}
		return false
	}
}
