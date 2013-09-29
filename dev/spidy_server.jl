using HttpServer, JSpidy

http = HttpHandler() do req::Request, res::Response
	if ismatch(r"^/jspidy/", req.resource)
		return Jspidy.process(raw);

	else
		return Response(404)
	end
end

# Basic event handlers
http.events["error"]  = ( client, err ) -> println( err )
http.events["listen"] = ( port )        -> println("Listening on $port...")

# Boot up the server
server = Server(http)
run(server, 8000)