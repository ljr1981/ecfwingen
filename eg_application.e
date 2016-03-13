note
	description: "[
		Representation of a root class {EG_APPLICATION}
		]"
	design: "[
		EG = ECF Generator
		]"

class
	EG_APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- `make' Current.
		do
			create application
			create window.make_with_title ("ECF Generator for Windows")
			window.close_request_actions.extend (agent application.destroy)
			window.set_size (550, 650)
			application.post_launch_actions.extend (agent window.show)
			application.launch
		end

feature {NONE} -- Implementation: GUI

	application: EV_APPLICATION

	window: EG_MAIN_WINDOW

end
