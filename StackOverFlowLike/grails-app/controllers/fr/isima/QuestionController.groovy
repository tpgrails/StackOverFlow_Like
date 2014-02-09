package fr.isima

import org.springframework.dao.DataIntegrityViolationException

class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	
	def voteup(){
		if(!QuestionService.isUserQuestion(session.userid,params.id))
			QuestionService.vote(params.id+"", 1,session.userid);
		
		redirect(controller: "question", action: "show", id: params.id)
		//render(view: "../question/show.gsp",model: [id: params.id])
	}
	
	def votedown(){
		if(!QuestionService.isUserQuestion(session.userid,params.id))
		QuestionService.vote(params.id+"", -1,session.userid);
		redirect(controller: "question", action: "show", id: params.id)
	}
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
		if(session.user == null){
			render(view: "../index.gsp",params: params)
		}
		else{
			params.max = Math.min(max ?: 10, 100)
			[questionInstanceList: Question.list(params), questionInstanceTotal: Question.count()]
		}
       
    }

    def create() {
		if(session.user == null){
			render(view: "../index.gsp",params: params)
		}
		else{
			User user = UserService.getUserById(session.userid)
			UserService.verificationReputation(session.userid,5)
			[questionInstance: new Question(params.title,params.content,user)]
		}
	
    }

    def save() {
		User user = UserService.getUserById(session.userid)
        def questionInstance = new Question(params.title,params.content,user)
        if (!questionInstance.save(flush: true)) {
            render(view: "create", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question')])
        redirect(action: "show", id: questionInstance.id)
    }

    def show(Long id) {
		
		if(session.user == null){
			render(view: "../index.gsp",params: params)
		}
		else{
			def listAnswer = AnswerService.getAnswersSorted(id)
			def questionInstance = Question.get(id)
			if (!questionInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
				redirect(action: "list")
				return
			}
			else{
				
				if(session.userid != questionInstance.user.id){
					questionInstance.view++
					questionInstance.save();
					
					
				}
			}
			def validate = AnswerService.isValidated(id)
			
			render(view: "show",  model: [questionInstance: questionInstance,listAnswer : listAnswer,validate:validate])
			/*
			[questionInstance: questionInstance]*/
		}
		
    }

    def edit(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance]
    }

    def update(Long id, Long version) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (questionInstance.version > version) {
                questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'question.label', default: 'Question')] as Object[],
                          "Another user has updated this Question while you were editing")
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            }
        }

        questionInstance.properties = params

        if (!questionInstance.save(flush: true)) {
            render(view: "edit", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "show", id: questionInstance.id)
    }

    def delete(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        try {
			
            questionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "show", id: id)
        }
    }
}
