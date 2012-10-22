package refreshbpm

import org.springframework.dao.DataIntegrityViolationException

class FeedController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [feedInstanceList: Feed.list(params), feedInstanceTotal: Feed.count()]
    }

    def create() {
        [feedInstance: new Feed(params)]
    }

    def save() {
        def feedInstance = new Feed(params)
        if (!feedInstance.save(flush: true)) {
            render(view: "create", model: [feedInstance: feedInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'feed.label', default: 'Feed'), feedInstance.id])
        redirect(action: "show", id: feedInstance.id)
    }

    def show() {
        def feedInstance = Feed.get(params.id)
        if (!feedInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'feed.label', default: 'Feed'), params.id])
            redirect(action: "list")
            return
        }

        [feedInstance: feedInstance]
    }

    def edit() {
        def feedInstance = Feed.get(params.id)
        if (!feedInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feed.label', default: 'Feed'), params.id])
            redirect(action: "list")
            return
        }

        [feedInstance: feedInstance]
    }

    def update() {
        def feedInstance = Feed.get(params.id)
        if (!feedInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feed.label', default: 'Feed'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (feedInstance.version > version) {
                feedInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'feed.label', default: 'Feed')] as Object[],
                          "Another user has updated this Feed while you were editing")
                render(view: "edit", model: [feedInstance: feedInstance])
                return
            }
        }

        feedInstance.properties = params

        if (!feedInstance.save(flush: true)) {
            render(view: "edit", model: [feedInstance: feedInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'feed.label', default: 'Feed'), feedInstance.id])
        redirect(action: "show", id: feedInstance.id)
    }

    def delete() {
        def feedInstance = Feed.get(params.id)
        if (!feedInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'feed.label', default: 'Feed'), params.id])
            redirect(action: "list")
            return
        }

        try {
            feedInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'feed.label', default: 'Feed'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'feed.label', default: 'Feed'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
