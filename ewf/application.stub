note
	description: "[
		Representation of a template Web Server {APPLICATION} 
			as a {WSF_DEFAULT_SERVICE} using {APP_EXECUTION} as
			a router/responder.
		]"

class
	APPLICATION

inherit
	WSF_DEFAULT_SERVICE [APP_EXECUTION]
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- `initialize' Current with optional "options".
		note
			design: "[
				In the code (below), this `initialize' feature is obtaining its option-settings
				from an "ini" file called "ewf.ini". You may use any "ini" file name you like,
				or none at all (see next note clause).
				
				The Precursor call executes ancestor `initialize' code.
				]"
			optional_feature: "[
				This feature is optional. If your design does not require specialized
				(non-default) options, then you may delete this feature and its redefine
				in the inherit clause (above).
				]"
		do
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("ewf.ini")
			Precursor
		end

note
	design: "[
	This class inherits: WSF_DEFAULT_SERVICE [APP_EXECUTION], 
	which answers two important questions:
	
	(1) What process (program) will be the Web Server (httpd)? 	--> {WSF_DEFAULT_SERVICE}
	(2) What process (program) will route request messages 
			coming through the Web Server and then serve up
			responses to the Web Client?						--> {APP_EXECUTION}
	
	See the {APP_EXECUTION} class for more details about request
	routing and reponse building-and-sending.
	]"

end
