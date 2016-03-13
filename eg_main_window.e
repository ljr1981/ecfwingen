note
	description: "[
		Representation of an {EG_MAIN_WINDOW}.
		]"

class
	EG_MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize
		end

create
	make_with_title

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		local
			l_env: EXECUTION_ENVIRONMENT
			l_randomizer: RANDOMIZER
		do
			create main_vbox

			create ecf_hbox
			create ecf_label.make_with_text ("ECF name:")
			create ecf_text.make_with_text ("[Enter ECF project name ...]")
			ecf_text.focus_in_actions.extend (agent ecf_text.select_all)

			create github_hbox
			create github_label.make_with_text ("GITHUB environment variable: ")
			create l_env
			if attached {STRING_32} l_env.starting_environment ["GITHUB"] as al_github_path  then
				create github_text.make_with_text (al_github_path)
			else
				create github_text.make_with_text ("Unknown ...")
			end
			github_text.disable_edit

			create uuid_hbox
			create uuid_label.make_with_text ("Generated UUID: ")
			create l_randomizer
			create uuid_text.make_with_text (l_randomizer.uuid.out)
			uuid_text.disable_edit

			create upper_libraries_hbox

			create std_lib_vbox
			create std_lib_label.make_with_text ("Std. Eiffel libraries: ")
			std_lib_label.align_text_left
			create std_lib_list
			std_lib_list.set_minimum_height (150)

			create threaded_check.make_with_text ("Threaded?")
			create scooped_check.make_with_text ("SCOOP'd?")
			create windows_app.make_with_text ("Windows application?")
			create docs_init.make_with_text ("Initialize docs folder?")

			create test_lib_vbox
			create test_lib_label.make_with_text ("Test libraries: ")
			test_lib_label.align_text_left
			create test_lib_list
			test_lib_list.set_minimum_height (150)


			create init_mock_check.make_with_text ("Create initial MOCK?")
			create init_test_set_check.make_with_text ("Create initial *_TEST_SET?")
			init_mock_check.toggle
			init_test_set_check.toggle

			create github_lib_vbox
			create github_lib_label.make_with_text ("GitHub libraries: ")
			github_lib_label.align_text_left
			create github_lib_list
			github_lib_list.set_minimum_height (150)

			create lower_libraries_hbox

			create control_hbox

			create control_create.make_with_text ("Create ECF")
			create control_cancel.make_with_text ("Cancel")

			create lower_vbox
			Precursor
		end

	initialize
			-- <Precursor>
		local
			l_file: PLAIN_TEXT_FILE
			l_list: LIST [STRING]
		do
			main_vbox.set_padding (2)
			main_vbox.set_border_width (2)

			ecf_hbox.extend (ecf_label)
			ecf_hbox.extend (ecf_text)
			ecf_hbox.disable_item_expand (ecf_label)

			ecf_hbox.set_padding (2)
			ecf_hbox.set_border_width (2)

			github_hbox.extend (github_label)
			github_hbox.extend (github_text)
			github_hbox.disable_item_expand (github_label)

			github_hbox.set_padding (2)
			github_hbox.set_border_width (2)

			uuid_hbox.extend (uuid_label)
			uuid_hbox.extend (uuid_text)
			uuid_hbox.disable_item_expand (uuid_label)

			uuid_hbox.set_padding (2)
			uuid_hbox.set_border_width (2)

			std_lib_vbox.extend (std_lib_label)
			std_lib_vbox.extend (std_lib_list)
			std_lib_vbox.extend (threaded_check)
			std_lib_vbox.extend (scooped_check)
			std_lib_vbox.extend (windows_app)
			std_lib_vbox.extend (docs_init)
			std_lib_vbox.disable_item_expand (std_lib_label)
			std_lib_vbox.disable_item_expand (std_lib_list)
			std_lib_vbox.disable_item_expand (threaded_check)
			std_lib_vbox.disable_item_expand (scooped_check)
			std_lib_vbox.disable_item_expand (windows_app)
			std_lib_vbox.disable_item_expand (docs_init)
			upper_libraries_hbox.extend (std_lib_vbox)

			std_lib_vbox.set_padding (2)
			std_lib_vbox.set_border_width (2)

			test_lib_vbox.extend (test_lib_label)
			test_lib_vbox.extend (test_lib_list)
			test_lib_vbox.extend (init_mock_check)
			test_lib_vbox.extend (init_test_set_check)
			test_lib_vbox.disable_item_expand (test_lib_label)
			test_lib_vbox.disable_item_expand (test_lib_list)
			test_lib_vbox.disable_item_expand (init_mock_check)
			test_lib_vbox.disable_item_expand (init_test_set_check)
			upper_libraries_hbox.extend (test_lib_vbox)

			test_lib_vbox.set_padding (2)
			test_lib_vbox.set_border_width (2)

			github_lib_vbox.extend (github_lib_label)
			github_lib_vbox.extend (github_lib_list)
			github_lib_vbox.disable_item_expand (github_lib_label)
			github_lib_vbox.disable_item_expand (github_lib_list)
			lower_libraries_hbox.extend (github_lib_vbox)

			github_lib_vbox.set_padding (2)
			github_lib_vbox.set_border_width (2)

			lower_libraries_hbox.extend (create {EV_CELL})

			lower_vbox.extend (upper_libraries_hbox)
			lower_vbox.extend (lower_libraries_hbox)

			lower_vbox.set_padding (2)
			lower_vbox.set_border_width (2)

			control_hbox.extend (create {EV_CELL})
			control_hbox.extend (control_create)
			control_hbox.extend (control_cancel)
			control_hbox.extend (create {EV_CELL})
			control_hbox.disable_item_expand (control_create)
			control_hbox.disable_item_expand (control_cancel)

			main_vbox.extend (ecf_hbox)
			main_vbox.extend (github_hbox)
			main_vbox.extend (uuid_hbox)
			main_vbox.extend (lower_vbox)
			main_vbox.extend (control_hbox)

			main_vbox.disable_item_expand (ecf_hbox)
			main_vbox.disable_item_expand (github_hbox)
			main_vbox.disable_item_expand (uuid_hbox)
			main_vbox.disable_item_expand (lower_vbox)
			main_vbox.disable_item_expand (control_hbox)

			extend (main_vbox)

				-- std_libs.ini
			create l_file.make_open_read ("std_libs.ini")
			l_file.read_stream (l_file.count)
			l_list := l_file.last_string.split ('%N')
			l_file.close

			across
				l_list as ic_list
			loop
				std_lib_list.force (create {EV_LIST_ITEM}.make_with_text (ic_list.item))
			end

				-- test_libs.ini
			create l_file.make_open_read ("test_libs.ini")
			l_file.read_stream (l_file.count)
			l_list := l_file.last_string.split ('%N')
			l_file.close

			across
				l_list as ic_list
			loop
				test_lib_list.force (create {EV_LIST_ITEM}.make_with_text (ic_list.item))
			end

				-- github_libs.ini
			create l_file.make_open_read ("github_libs.ini")
			l_file.read_stream (l_file.count)
			l_list := l_file.last_string.split ('%N')
			l_file.close

			across
				l_list as ic_list
			loop
				github_lib_list.force (create {EV_LIST_ITEM}.make_with_text (ic_list.item))
			end

			control_create.select_actions.extend (agent on_create)
			control_cancel.select_actions.extend (agent close_request_actions.call ([Void]))

			Precursor
		end

feature {NONE} -- Implementation: Basic Operations

	on_create
			-- `on_create'.
		do
			do_nothing -- yet ...
		end

feature {NONE} -- Implementation: GUI

	main_vbox: EV_VERTICAL_BOX

	ecf_hbox: EV_HORIZONTAL_BOX
	ecf_label: EV_LABEL
	ecf_text: EV_TEXT_FIELD

	github_hbox: EV_HORIZONTAL_BOX
	github_label: EV_LABEL
	github_text: EV_TEXT_FIELD

	uuid_hbox: EV_HORIZONTAL_BOX
	uuid_label: EV_LABEL
	uuid_text: EV_TEXT_FIELD

	upper_libraries_hbox: EV_HORIZONTAL_BOX

	std_lib_vbox: EV_VERTICAL_BOX
	std_lib_label: EV_LABEL
	std_lib_list: EV_CHECKABLE_LIST

	threaded_check: EV_CHECK_BUTTON
	scooped_check: EV_CHECK_BUTTON
	windows_app: EV_CHECK_BUTTON
	docs_init: EV_CHECK_BUTTON

	test_lib_vbox: EV_VERTICAL_BOX
	test_lib_label: EV_LABEL
	test_lib_list: EV_CHECKABLE_LIST

	init_mock_check: EV_CHECK_BUTTON
	init_test_set_check: EV_CHECK_BUTTON

	lower_libraries_hbox: EV_HORIZONTAL_BOX

	github_lib_vbox: EV_VERTICAL_BOX
	github_lib_label: EV_LABEL
	github_lib_list: EV_CHECKABLE_LIST

	control_hbox: EV_HORIZONTAL_BOX
	control_create: EV_BUTTON
	control_cancel: EV_BUTTON

	lower_vbox: EV_VERTICAL_BOX

end
