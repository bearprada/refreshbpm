package refreshbpm

import org.springframework.dao.DataIntegrityViolationException

class EmotionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [emotionInstanceList: Emotion.list(params), emotionInstanceTotal: Emotion.count()]
    }

    def create() {
        [emotionInstance: new Emotion(params)]
    }

    def save() {
        def emotionInstance = new Emotion(params)
        if (!emotionInstance.save(flush: true)) {
            render(view: "create", model: [emotionInstance: emotionInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'emotion.label', default: 'Emotion'), emotionInstance.id])
        redirect(action: "show", id: emotionInstance.id)
    }

    def show() {
        def emotionInstance = Emotion.get(params.id)
        if (!emotionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'emotion.label', default: 'Emotion'), params.id])
            redirect(action: "list")
            return
        }

        [emotionInstance: emotionInstance]
    }

    def edit() {
        def emotionInstance = Emotion.get(params.id)
        if (!emotionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'emotion.label', default: 'Emotion'), params.id])
            redirect(action: "list")
            return
        }

        [emotionInstance: emotionInstance]
    }

    def update() {
        def emotionInstance = Emotion.get(params.id)
        if (!emotionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'emotion.label', default: 'Emotion'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (emotionInstance.version > version) {
                emotionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'emotion.label', default: 'Emotion')] as Object[],
                          "Another user has updated this Emotion while you were editing")
                render(view: "edit", model: [emotionInstance: emotionInstance])
                return
            }
        }

        emotionInstance.properties = params

        if (!emotionInstance.save(flush: true)) {
            render(view: "edit", model: [emotionInstance: emotionInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'emotion.label', default: 'Emotion'), emotionInstance.id])
        redirect(action: "show", id: emotionInstance.id)
    }

    def delete() {
        def emotionInstance = Emotion.get(params.id)
        if (!emotionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'emotion.label', default: 'Emotion'), params.id])
            redirect(action: "list")
            return
        }

        try {
            emotionInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'emotion.label', default: 'Emotion'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'emotion.label', default: 'Emotion'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
