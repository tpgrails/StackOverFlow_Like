package fr.isima

import org.springframework.dao.DataIntegrityViolationException

class AnswerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def voteup(){
		// if the answer was not posted by the current user
		if(!AnswerService.isUserAnswer(session.userid,params.id))
			AnswerService.vote(params.id+"", 1,session.userid);
	
		redirect(controller: "question", action: "show", id: params.idquestion)
		//render(view: "../question/show.gsp",model: [id: params.id])
	}
	
	def votedown(){
		// if the answer was not posted by the current user
		if(!AnswerService.isUserAnswer(session.userid,params.id))
		AnswerService.vote(params.id+"", -1,session.userid);

		redirect(controller: "question", action: "show", id: params.idquestion)
	}
	
	def validate(){
		AnswerService.validate(params.id)
		redirect(controller: "question", action: "show", id: params.idquestion,params:[validate : 1])
		
	}
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [answerInstanceList: Answer.list(params), answerInstanceTotal: Answer.count()]
    }

    def create() {
		User user = UserService.getUserById(session.userid)
		UserService.verificationReputation(session.userid,10)
		Question question = QuestionService.getQuestion(params.idquestion)
        [answerInstance: new Answer(params.content, user, question)]
    }

    def save() {
		User user = UserService.getUserById(session.userid)
		Question question = QuestionService.getQuestion(params.idquestion)
        def answerInstance = new Answer(params.content, user, question)
        if (!answerInstance.save(flush: true)) {
			
            render(view: "create", model: [answerInstance: answerInstance])
			
            return
        }

        //flash.message = message(code: 'default.created.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
        //redirect(action: "show", id: answerInstance.id)
		flash.message = message(code:'message.reponse.success')
		redirect(controller: 'question', action:'list',params: params)
    }

    def show(Long id) {
        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
            return
        }

        [answerInstance: answerInstance]
    }

    def edit(Long id) {
        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
            return
        }

        [answerInstance: answerInstance]
    }

    def update(Long id, Long version) {
        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (answerInstance.version > version) {
                answerInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'answer.label', default: 'Answer')] as Object[],
                          "Another user has updated this Answer while you were editing")
                render(view: "edit", model: [answerInstance: answerInstance])
                return
            }
        }

        answerInstance.properties = params

        if (!answerInstance.save(flush: true)) {
            render(view: "edit", model: [answerInstance: answerInstance])
            return
        }
		def questionid = answerInstance.question.id
        flash.message = message(code: 'default.updated.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
		redirect(controller: 'question',action: "show", id: questionid)
		
		//redirect(action: "show", id: answerInstance.id)
    }

    def delete(Long id) {
        def answerInstance = Answer.get(id)
		def questionid = answerInstance.question.id
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
            return
        }

        try {
            answerInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            //redirect(action: "list")
			redirect(controller: 'question',action: "show", id: questionid)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "show", id: id)
        }
    }
}
