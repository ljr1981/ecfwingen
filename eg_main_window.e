note
	description: "[
		Representation of an {EG_MAIN_WINDOW}.
		]"
	design: "See the `design' feature note at the end of this class."
	caution: "[
		PLEASE READ ALL NOTES AND CODE BEFORE MODIFYING! 
		
		HINT: Start with the notes at the bottom of the class!
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

				-- ECF widgets ...
			create ecf_hbox
			create ecf_label.make_with_text ("ECF name:")
			create ecf_text.make_with_text ("[Enter ECF project name ...]")
			ecf_text.focus_in_actions.extend (agent ecf_text.select_all)

				-- Github widgets ...
			create github_hbox
			create github_label.make_with_text ("GITHUB environment variable: ")
			create l_env
			if attached {STRING_32} l_env.starting_environment ["GITHUB"] as al_github_path  then
				create github_text.make_with_text (al_github_path)
			else
				create github_text.make_with_text ("Unknown ...")
			end
			github_text.disable_edit

				-- UUID widgets ...
			create uuid_hbox
			create uuid_label.make_with_text ("Generated UUID: ")
			create l_randomizer
			create uuid_text.make_with_text (l_randomizer.uuid.out)
			uuid_text.disable_edit

			create upper_libraries_hbox

				-- Std Library widgets ...
			create std_lib_vbox
			create std_lib_label.make_with_text ("Std. Eiffel libraries: ")
			std_lib_label.align_text_left
			create std_lib_list
			std_lib_list.set_minimum_height (150)

			create threaded_check.make_with_text ("Threaded?")
			create scooped_check.make_with_text ("SCOOP'd?")
			create windows_app.make_with_text ("Windows application?")
			create docs_init.make_with_text ("Initialize docs folder?")

				-- Testing Library widgets ...
			create test_lib_vbox
			create test_lib_label.make_with_text ("Test libraries: ")
			test_lib_label.align_text_left
			create test_lib_list
			test_lib_list.set_minimum_height (150)


			create init_mock_check.make_with_text ("Create initial MOCK?")
			create init_test_set_check.make_with_text ("Create initial *_TEST_SET?")
			init_mock_check.toggle
			init_test_set_check.toggle

				-- Github Library widgets ...
			create github_lib_vbox
			create github_lib_label.make_with_text ("GitHub libraries: ")
			github_lib_label.align_text_left
			create github_lib_list
			github_lib_list.set_minimum_height (150)

			create lower_libraries_hbox

				-- Create and Cancel widgets ...
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
				-- ECF information
			ecf_hbox.extend (ecf_label)
			ecf_hbox.extend (ecf_text)
			ecf_hbox.disable_item_expand (ecf_label)

			ecf_hbox.set_padding (2)
			ecf_hbox.set_border_width (2)

				-- GITHUB information
			github_hbox.extend (github_label)
			github_hbox.extend (github_text)
			github_hbox.disable_item_expand (github_label)

			github_hbox.set_padding (2)
			github_hbox.set_border_width (2)

				-- UUID information
			uuid_hbox.extend (uuid_label)
			uuid_hbox.extend (uuid_text)
			uuid_hbox.disable_item_expand (uuid_label)

			uuid_hbox.set_padding (2)
			uuid_hbox.set_border_width (2)

				-- Standard libraries
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

				-- Test libraries
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

				-- Github libraries
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

				-- Create and cancel controls
			control_hbox.extend (create {EV_CELL})
			control_hbox.extend (control_create)
			control_hbox.extend (control_cancel)
			control_hbox.extend (create {EV_CELL})
			control_hbox.disable_item_expand (control_create)
			control_hbox.disable_item_expand (control_cancel)

			control_create.select_actions.extend (agent on_create)
			control_cancel.select_actions.extend (agent close_request_actions.call ([Void]))

				-- Put all in `main_vbox' ...
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

			main_vbox.set_padding (2)
			main_vbox.set_border_width (2)

				-- Put `main_vbox' into window (Current) ...
			extend (main_vbox)

				-- Load "lists" from "ini" files (standard, test, and github)
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

			Precursor
		end

feature {NONE} -- Implementation: Basic Operations

	ecf_content: STRING
			-- `ecf_content' which will get written to ECF file.
		attribute
			create Result.make_empty
		end

	on_create
			-- What happens `on_create'.
		do
			build_ecf_content
			process_ecf_content
		end

	build_ecf_content
			-- `build_ecf_content'.
		do
			ecf_content := constants.ecf_template_string.twin
			replace_ecf_project_name (ecf_content, ecf_text.text)
			replace_uuid (ecf_content, uuid_text.text)
			replace_scoopable (ecf_content, scooped_check.is_selected)
			replace_standard (ecf_content)
			replace_github (ecf_content)
			replace_testing (ecf_content)
		end

	process_ecf_content
			-- `process_ecf_content'.
		note
			replace_me: "The dialog solution (below) is not what we ultiamtely want. This is temporary code. Remove it."
		local
			l_dialog: EV_MESSAGE_DIALOG
		do
			create l_dialog.make_with_text (ecf_content)
			l_dialog.set_buttons_and_actions (<<"OK">>, <<agent l_dialog.destroy_and_exit_if_last>>)
			l_dialog.show
		end

feature {NONE} -- Implementation: Replacement

	replace_standard (a_content: STRING)
			-- `replace_standard' libraries list in `a_content'.
		do
			check attached {STRING} constants.tag_list.item (constants.standard_library_list_tag) as al_tag then
				replace_library (a_content, constants.standard_library_list_item_template_string, al_tag, std_lib_list)
			end
		end

	replace_github (a_content: STRING)
			-- `replace_github' libraries list in `a_content'.
		do
			check attached {STRING} constants.tag_list.item (constants.github_library_list_tag) as al_tag then
				replace_library (a_content, constants.github_library_list_item_template_string, al_tag, github_lib_list)
			end
		end

	replace_testing (a_content: STRING)
			-- `replace_testing' libraries list in `a_content'.
		do
			check attached {STRING} constants.tag_list.item (constants.testing_library_list_tag) as al_tag then
				replace_library (a_content, constants.testing_library_list_item_template_string, al_tag, test_lib_list)
			end
		end

	replace_library (a_content, a_library_template_string, a_library_list_tag: STRING; a_list: EV_CHECKABLE_LIST)
			-- `replace_library' tags in `a_content' using `a_library_template_string' and `a_library_list_tag' from `a_list' of items.
		local
			l_replacement: STRING
		do
			create l_replacement.make_empty
			across
				a_list.checked_items as ic_list
			loop
				l_replacement.append_character ('%T')
				l_replacement.append_character ('%T')
				l_replacement.append_string (a_library_template_string)
				check attached {STRING} constants.tag_list.item (constants.library_name_tag) as al_tag then
					l_replacement.replace_substring_all (al_tag, ic_list.item.text)
					l_replacement.append_character ('%N')
				end
			end
			a_content.replace_substring_all (a_library_list_tag, l_replacement)
		end

	replace_scoopable (a_content: STRING; a_is_scooped: BOOLEAN)
			-- `replace_scoopable' tag with `a_content' if `a_is_scooped' is set.
		do
			check attached {STRING} constants.tag_list.item (constants.scoopable_tag) as al_tag then
				if a_is_scooped then
					a_content.replace_substring_all (al_tag, constants.scoop_setting_template_string)
				else
					a_content.replace_substring_all (al_tag + "%N", create {STRING}.make_empty)
				end
			end
		end

	replace_uuid (a_content, a_uuid: STRING)
			-- `replace_uuid' tag with `a_content' with `a_uuid'.
		do
			check attached {STRING} constants.tag_list.item (constants.uuid_tag) as al_tag then
				a_content.replace_substring_all (al_tag, a_uuid)
			end
		end

	replace_ecf_project_name (a_content, a_project_name: STRING)
		do
			check attached {STRING} constants.tag_list.item (constants.ecf_name_tag) as al_tag then
				a_content.replace_substring_all (al_tag, a_project_name)
			end
		end

feature {NONE} -- Implementation: GUI

	main_vbox: EV_VERTICAL_BOX

		-- ECF controls
	ecf_hbox: EV_HORIZONTAL_BOX
	ecf_label: EV_LABEL
	ecf_text: EV_TEXT_FIELD

		-- GITHUB controls
	github_hbox: EV_HORIZONTAL_BOX
	github_label: EV_LABEL
	github_text: EV_TEXT_FIELD

		-- UUID controls
	uuid_hbox: EV_HORIZONTAL_BOX
	uuid_label: EV_LABEL
	uuid_text: EV_TEXT_FIELD

	upper_libraries_hbox: EV_HORIZONTAL_BOX

		-- Std Library controls
	std_lib_vbox: EV_VERTICAL_BOX
	std_lib_label: EV_LABEL
	std_lib_list: EV_CHECKABLE_LIST

	threaded_check: EV_CHECK_BUTTON
	scooped_check: EV_CHECK_BUTTON
	windows_app: EV_CHECK_BUTTON
	docs_init: EV_CHECK_BUTTON

		-- Testing Library controls
	test_lib_vbox: EV_VERTICAL_BOX
	test_lib_label: EV_LABEL
	test_lib_list: EV_CHECKABLE_LIST

	init_mock_check: EV_CHECK_BUTTON
	init_test_set_check: EV_CHECK_BUTTON

	lower_libraries_hbox: EV_HORIZONTAL_BOX

		-- Github Library controls
	github_lib_vbox: EV_VERTICAL_BOX
	github_lib_label: EV_LABEL
	github_lib_list: EV_CHECKABLE_LIST

		-- Create and Cancel controls
	control_hbox: EV_HORIZONTAL_BOX
	control_create: EV_BUTTON
	control_cancel: EV_BUTTON

	lower_vbox: EV_VERTICAL_BOX

feature {NONE} -- Implementation: Constants

	constants: EG_CONSTANTS
			-- `constants'
		once
			create Result
		end

note
	design: "[
		This is the main window for the application. It consists of several
		important parts:

		(1) redefined `create_interface_objects'
			* GUI components (i.e. labels, text boxes, lists, and containers)
				must be "created" first. This redefined feature is where this
				happens for all GUI elements. If you add components, do so here.

		(2)	redefined `initialize'

			- After creation (above), GUI components can be initialized. This
				"process" includes a number of factors:

				(a) Some objects are contained while others are containers.
					The `initialize' feature is the place where we put contained
					things into their containers and containers into other
					containers. Ultimately, we put a primary container (e.g.
					`main_vbox') into the window (e.g. "extend (main_vbox)").

				(b) Beyond simple containership, we have settings on the controls
					themselves. We are concerned with size, content, text, color,
					fonts, and other matters about appearance.

				(c) Next is behavior: What do our controls do when they are clicked,
					hovered over, selected, checked, and other behavioral matters.
					This is usually where agents get created and placed on `*_actions'.

		(3) Feature group "Basic Operations"

			- The goal of this form is to (a) build the ECF text content into the
				feature `ecf_content'. (b) Once the ECF content is constructed,
				it is ready to write out to disk along with other files (e.g.
				*_TEST_SET.e and MOCK_*.e files).
			- Of special note are the `replace_*' features which are each called
				in turn. They compute the text that will ultimately replace the
				<<TAGS>> found in the "template" constant strings (in {EG_CONSTANTS}).

		(4) Feature group "Replacement"

			- There are a number of `replace_*' features. Each one is responsible for
				replacing one of the <<TAG>> items in an `ecf_constant' string, which
				is loaded from a "template" constant string in the {EG_CONSTANT} class.
			- Features like `replace_ecf_project_name' and `replace_uuid' get their data
				from a field or other computation of a single field of data. Usually,
				the data is derived from one of the controls on the form.
			- Features like `replace_standard', `replace_github', and `replace_testing'
				work by going across the "clicked" items of an {EV_CHECKABLE_LIST}.
				Each item in the list represents a library that the user would like
				to include in their new ECF project file. There is a single feature
				called `replace_libary', which knows how to do the job of building
				the list of replacements generically and is called by each of the more
				specialized versions: `replace_standard', `replace_github' and (finally)
				`replace_testing'.

		(5) Feature group "GUI"
		
			- The GUI group is a list of all of the GUI items used by the current
				main window. They are grouped together around each type of control
				you see on the final screen when the program is executed. Please
				pay special attention to what types of controls are used and how
				they work together. Specifically: Primitives and Containers.
			- Primitives are controls like: {EV_LABEL}, {EV_TEXT_FIELD}, and
				{EC_CHECKABLE_LIST} or {EV_CHECK_BUTTON}. These names ought to
				give you a good idea of what they do, what they look like, and
				how they behave for the user.
			- Containers come in three flavors: {EV_VERTICAL_BOX}, {EV_HORIZONTAL_BOX},
				and {EV_CELL}. Boxes are containers that you put "stuff" in (e.g. Primitives).
				Vertical boxes present their widgets vertically (one on top of the other).
				Horizontal boxes present their widgets left-to-right, first-in-first-presented
				(verticals are top-to-bottom, first-in-first-presented). A "cell" is a
				container for just one and only one Primitive widget. They are mainly used
				as "place-holders" for where we want: (a) A single widget -OR- (b) empty space.
			- Padding and Borders: Padding is how many pixels to put between items in a
				containers interior. Borders is how many pixels to put between the container
				and other containers around it on its exterior.
			- Item Expansion: All of the "BOXES" classes in Eiffel try to expand themselves
				(and their contained stuff) to the maximum amount of visual space available.
				Thus, a container with two widgets will have widget A and B each taking
				50% (e.g. 1/2) of the visually available space. As the container is resized
				the widgets will automatically attempt to expand to contract depending on
				how the container is sized up or down. If you want a widget to contract to
				the smallest space it can, then you must tell the container to `disable_item_expand'
				for a specific widget. You will see this in the `initialize' code (above).
			
		(6) Feature group "Constants"
		
			- There is a constants class called {EG_CONSTANTS}. This class has a number of
				useful features will will make your life easier while coding and maintaining
				this class. We could have used a static reference, but it was easier to
				create a reference and then access the constants through calls to the
				`constants' feature (see the code above).
		]"
	navigation: "[
		HINTS: Review the Quick Reference PDF (EIS link below) to recall:
		
		(1) Use pick-n-drop to navigate through features and discover what connects to what.
		(2) PnD features to the feature tool and then click "callers" to see who calls that feature.
		(3) PnD features to the feature tool and then click "basic text view" to see the feature by itself.
		(4) PnD features to the feature tool and then click "callees" to see what features are called by the one you dropped.
		(5) Explore the other tools in the features tool (below). See the Quick Reference guide (below) for more.
		]"
		EIS: "src=$GITHUB\sav_training\docs\Eiffel Studio - Class Tool - Quick Reference.pdf"
end
