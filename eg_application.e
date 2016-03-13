note
	description: "Summary description for {EG_APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- ??
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
