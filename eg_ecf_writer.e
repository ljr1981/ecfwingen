note
	description: "[
		Representation of an {EG_ECF_WRITER}
		]"
	design: "[
		The goal is to write a new ECF into a common folder structure. This class
		contains the information required to build the ECF file and the folders
		and files.
		]"

class
	EG_ECF_WRITER

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			create ecf_name.make_empty
			create root_folder_name.make_empty
			create ecf_uuid
			create std_libraries.make (10)
			create test_libraries.make (10)
			create github_libraries.make (10)
		end

feature -- Access

	ecf_name: STRING_ATTRIBUTE
			-- `ecf_name' (project and file).

	root_folder_name: STRING_ATTRIBUTE
			-- `root_folder_name' for `ecf_name' file.

	ecf_uuid: UUID_ATTRIBUTE
			-- `ecf_uuid' for ECF file.

	std_libraries: ARRAYED_LIST [STRING]
			-- `std_libararies' list.

	is_threaded: BOOLEAN

	is_scooped: BOOLEAN

	is_windows_app: BOOLEAN

	is_docs_init: BOOLEAN

	test_libraries: ARRAYED_LIST [STRING]

	is_init_mock: BOOLEAN

	is_init_test_set: BOOLEAN

	github_libraries: ARRAYED_LIST [STRING]

feature -- Settings

	set_ecf_name (a_name: like ecf_name.attached_item)
			-- `set_ecf_name' with `a_name'.
		do
			ecf_name.set_item (a_name)
		end

	set_root_folder_name (a_name: like root_folder_name.attached_item)
			-- `' with `a_name'.
		do
			root_folder_name.set_item (a_name)
		end

	set_uuid_with_text (a_uuid_string: STRING)
		do
			create ecf_uuid.make_with_objects (create {UUID}.make_from_string (a_uuid_string))
		end

end
