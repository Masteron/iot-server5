

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache



struct mustacheHelper: MustachePageHandler {
    var values:  MustacheEvaluationContext.MapType
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
                let response = contxt.webResponse
                response.appendBody(string: "\(error)")
                response.completed()
            }
        }
    }

class Handlers  {
    func index(request: HTTPRequest, response: HTTPResponse){
        var values = MustacheEvaluationContext.MapType()
        values["title"]="Главная страница"
        mustacheRequest(request: request, response: response, handler: mustacheHelper(values: values),
                        templatePath:"\(request.documentRoot)/index.html")
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

let handlers = Handlers()
let server = HTTPServer()
var routes = Routes()
server.serverPort = 8080
server.documentRoot="webroot"

routes.add(method: .get, uri:"/", handler: handlers.index)
routes.add(method: .get, uri:"/index", handler: handlers.index)

server.addRoutes(routes)
do {
    try server.start()
}catch {
	fatalError("\(error)")
}

