package refreshbpm

import org.springframework.dao.DataIntegrityViolationException

class EmotionGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [emotionGroupInstanceList: EmotionGroup.list(params), emotionGroupInstanceTotal: EmotionGroup.count()]
    }

    def create() {
        [emotionGroupInstance: new EmotionGroup(params)]
    }

    def save() {
        def emotionGroupInstance = new EmotionGroup(params)
        if (!emotionGroupInstance.save(flush: true)) {
            render(view: "create", model: [emotionGroupInstance: emotionGroupInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'emotionGroup.label', default: 'EmotionGroup'), emotionGroupInstance.id])
        redirect(action: "show", id: emotionGroupInstance.id)
    }

    def show() {
        def emotionGroupInstance = EmotionGroup.get(params.id)
        if (!emotionGroupInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'emotionGroup.label', default: 'EmotionGroup'), params.id])
            redirect(action: "list")
            return
        }

        [emotionGroupInstance: emotionGroupInstance]
    }

    def edit() {
        def emotionGroupInstance = EmotionGroup.get(params.id)
        if (!emotionGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'emotionGroup.label', default: 'EmotionGroup'), params.id])
            redirect(action: "list")
            return
        }

        [emotionGroupInstance: emotionGroupInstance]
    }

    def update() {
        def emotionGroupInstance = EmotionGroup.get(params.id)
        if (!emotionGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'emotionGroup.label', default: 'EmotionGroup'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (emotionGroupInstance.version > version) {
                emotionGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'emotionGroup.label', default: 'EmotionGroup')] as Object[],
                          "Another user has updated this EmotionGroup while you were editing")
                render(view: "edit", model: [emotionGroupInstance: emotionGroupInstance])
                return
            }
        }

        emotionGroupInstance.properties = params

        if (!emotionGroupInstance.save(flush: true)) {
            render(view: "edit", model: [emotionGroupInstance: emotionGroupInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'emotionGroup.label', default: 'EmotionGroup'), emotionGroupInstance.id])
        redirect(action: "show", id: emotionGroupInstance.id)
    }

    def delete() {
        def emotionGroupInstance = EmotionGroup.get(params.id)
        if (!emotionGroupInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'emotionGroup.label', default: 'EmotionGroup'), params.id])
            redirect(action: "list")
            return
        }

        try {
            emotionGroupInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'emotionGroup.label', default: 'EmotionGroup'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'emotionGroup.label', default: 'EmotionGroup'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
