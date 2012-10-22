package refreshbpm

import org.springframework.dao.DataIntegrityViolationException

class HappinessCityController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [happinessCityInstanceList: HappinessCity.list(params), happinessCityInstanceTotal: HappinessCity.count()]
    }

    def create() {
        [happinessCityInstance: new HappinessCity(params)]
    }

    def save() {
        def happinessCityInstance = new HappinessCity(params)
        if (!happinessCityInstance.save(flush: true)) {
            render(view: "create", model: [happinessCityInstance: happinessCityInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'happinessCity.label', default: 'HappinessCity'), happinessCityInstance.id])
        redirect(action: "show", id: happinessCityInstance.id)
    }

    def show() {
        def happinessCityInstance = HappinessCity.get(params.id)
        if (!happinessCityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'happinessCity.label', default: 'HappinessCity'), params.id])
            redirect(action: "list")
            return
        }

        [happinessCityInstance: happinessCityInstance]
    }

    def edit() {
        def happinessCityInstance = HappinessCity.get(params.id)
        if (!happinessCityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'happinessCity.label', default: 'HappinessCity'), params.id])
            redirect(action: "list")
            return
        }

        [happinessCityInstance: happinessCityInstance]
    }

    def update() {
        def happinessCityInstance = HappinessCity.get(params.id)
        if (!happinessCityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'happinessCity.label', default: 'HappinessCity'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (happinessCityInstance.version > version) {
                happinessCityInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'happinessCity.label', default: 'HappinessCity')] as Object[],
                          "Another user has updated this HappinessCity while you were editing")
                render(view: "edit", model: [happinessCityInstance: happinessCityInstance])
                return
            }
        }

        happinessCityInstance.properties = params

        if (!happinessCityInstance.save(flush: true)) {
            render(view: "edit", model: [happinessCityInstance: happinessCityInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'happinessCity.label', default: 'HappinessCity'), happinessCityInstance.id])
        redirect(action: "show", id: happinessCityInstance.id)
    }

    def delete() {
        def happinessCityInstance = HappinessCity.get(params.id)
        if (!happinessCityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'happinessCity.label', default: 'HappinessCity'), params.id])
            redirect(action: "list")
            return
        }

        try {
            happinessCityInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'happinessCity.label', default: 'HappinessCity'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'happinessCity.label', default: 'HappinessCity'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
