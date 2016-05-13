note
	description: "[
		Representation of {EG_CONSTANTS}
		]"

class
	EG_CONSTANTS

feature -- Constants

	tag_list: HASH_TABLE [STRING, INTEGER]
			-- `tag_list' for replacement tags in Current.
		once
			create Result.make (20)
			Result.force ("<<ECF_NAME>>", 1)
			Result.force ("<<UUID>>", 2)
			Result.force ("<<SCOOPABLE>>", 3)
			Result.force ("<<STANDARD_LIBRARY_LIST>>", 4)
			Result.force ("<<GITHUB_LIBRARAY_LIST>>", 5)
			Result.force ("<<TESTING_LIBRARY_LIST>>", 6)
			Result.force ("<<LIBRARY_NAME>>", 7)
			Result.force ("<<EWF_LIBRARY_LIST>>", 8)
			Result.force ("<<PATH_FRAGMENT>>", 9)
		end

	ecf_name_tag: INTEGER = 1
	uuid_tag: INTEGER = 2
	scoopable_tag: INTEGER = 3
	standard_library_list_tag: INTEGER = 4
	github_library_list_tag: INTEGER = 5
	testing_library_list_tag: INTEGER = 6
	library_name_tag: INTEGER = 7
	ewf_library_list_tag: INTEGER = 8
	path_fragment_tag: INTEGER = 9

	root_class_and_procedure_app_tag: STRING = "<<ROOT_CLASS_PROCEDURE>>"
	root_class_and_proceudre_test_tag: STRING = "<<ROOT_CLASS_PROCEDURE_TEST>>"

	root_for_compile_all: STRING = "<root all_classes=%"true%"/>"
	root_for_testing: STRING = "<root class=%"ANY%" feature=%"default_create%"/>"
	root_for_ewf: STRING = "<root class=%"APPLICATION%" feature=%"make_and_launch%"/>"

	ecf_template_string: STRING = "[
<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-15-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-15-0 http://www.eiffel.com/developers/xml/configuration-1-15-0.xsd" name="<<ECF_NAME>>" uuid="<<UUID>>" readonly="false">
	<description><<ECF_NAME>> implementation</description>
	<target name="<<ECF_NAME>>">
		<<ROOT_CLASS_PROCEDURE>>
		<option warning="true" void_safety="transitional" syntax="provisional">
			<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
		</option>
		<setting name="console_application" value="true"/>
<<SCOOPABLE>>
<<STANDARD_LIBRARY_LIST>>
<<GITHUB_LIBRARAY_LIST>>
<<EWF_LIBRARY_LIST>>
		<library name="test_extension" location="$GITHUB\test_extension\test_extension.ecf"/>
		<cluster name="<<ECF_NAME>>" location=".\" recursive="true">
			<file_rule>
				<exclude>/.git$</exclude>
				<exclude>/.svn$</exclude>
				<exclude>/CVS$</exclude>
				<exclude>/EIFGENs$</exclude>
				<exclude>tests</exclude>
			</file_rule>
		</cluster>
	</target>
	<target name="test" extends="<<ECF_NAME>>">
		<description><<ECF_NAME>> Tests</description>
		<<ROOT_CLASS_PROCEDURE_TEST>>
		<file_rule>
			<exclude>/.git$</exclude>
			<exclude>/.svn$</exclude>
			<exclude>/CVS$</exclude>
			<exclude>/EIFGENs$</exclude>
			<include>tests</include>
		</file_rule>
		<option profile="false">
		</option>
		<setting name="console_application" value="false"/>
<<TESTING_LIBRARY_LIST>>
		<cluster name="tests" location=".\tests\" recursive="true"/>
	</target>
</system>

]"

	scoop_setting_template_string: STRING = "[
		<setting name="concurrency" value="scoop"/>
]"

	standard_library_list_item_template_string: STRING = "[
		<library name="<<LIBRARY_NAME>>" location="$ISE_LIBRARY\library\<<LIBRARY_NAME>>\<<LIBRARY_NAME>>-safe.ecf"/>
]"

	github_library_list_item_template_string: STRING = "[
		<library name="<<LIBRARY_NAME>>" location="$GITHUB\<<LIBRARY_NAME>>\<<LIBRARY_NAME>>.ecf"/>
]"

	ewf_library_list_item_template_string: STRING = "[
		<library name="<<LIBRARY_NAME>>" location="$GITHUB\ewf\library\<<PATH_FRAGMENT>>"/>
]"

	http_library_name_string: STRING = 					"http-safe"
	http_library_string: STRING = 						"network\protocol\http\http-safe.ecf"
	default_standalone_library_name_string: STRING =	"default_standalone"
	default_standalone_library_string: STRING = 		"server\wsf\default\standalone-safe.ecf"
	wsf_library_name_string: STRING = 					"wsf-safe"
	wsf_library_string: STRING = 						"server\wsf\wsf-safe.ecf"
	encoder_library_name_string: STRING = 				"encoder-safe"
	encoder_library_string: STRING = 					"text\encoder\encoder-safe.ecf"

	testing_library_list_item_template_string: STRING = "[
		<library name="<<LIBRARY_NAME>>" location="$ISE_LIBRARY\library\<<LIBRARY_NAME>>\<<LIBRARY_NAME>>-safe.ecf"/>
]"

	test_class_template_string: STRING = "[
note
	description: "Tests of {<<TEST_CLASS_NAME>>}."
	testing: "type/manual"

class
	<<TEST_CLASS_NAME>>_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	<<TEST_CLASS_NAME>>_tests
			-- `<<TEST_CLASS_NAME>>_tests'
		do
			do_nothing -- yet ...
		end

end

]"

	EWF_application_class_text: STRING
			-- `EWF_application_class_text' or APPLICATION.e
		local
			l_directory: DIRECTORY
			l_path: PATH
			l_file: PLAIN_TEXT_FILE
			l_env: EXECUTION_ENVIRONMENT
		once
			create Result.make_empty
			create l_env
			create l_path.make_from_string (l_env.current_working_path.name + "\ewf\application.stub")
			create l_file.make_open_read (l_path.name.out)
			l_file.read_stream (l_file.count)
			Result := l_file.last_string.twin
			l_file.close
		end

	EWF_app_execution_class_text: STRING
			-- `EWF_app_execution_class_text' or APP_EXECUTION.e
		local
			l_directory: DIRECTORY
			l_path: PATH
			l_file: PLAIN_TEXT_FILE
			l_env: EXECUTION_ENVIRONMENT
		once
			create Result.make_empty
			create l_env
			create l_path.make_from_string (l_env.current_working_path.name + "\ewf\app_execution.stub")
			create l_file.make_open_read (l_path.name.out)
			l_file.read_stream (l_file.count)
			Result := l_file.last_string.twin
			l_file.close
		end

	EWF_ini_text: STRING
			-- `EWF_ini_text' or APP_EXECUTION.e
		local
			l_directory: DIRECTORY
			l_path: PATH
			l_file: PLAIN_TEXT_FILE
			l_env: EXECUTION_ENVIRONMENT
		once
			create Result.make_empty
			create l_env
			create l_path.make_from_string (l_env.current_working_path.name + "\ewf\ewf.ini")
			create l_file.make_open_read (l_path.name.out)
			l_file.read_stream (l_file.count)
			Result := l_file.last_string.twin
			l_file.close
		end

end
