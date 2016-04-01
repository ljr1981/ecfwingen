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
		end

	ecf_name_tag: INTEGER = 1
	uuid_tag: INTEGER = 2
	scoopable_tag: INTEGER = 3
	standard_library_list_tag: INTEGER = 4
	github_library_list_tag: INTEGER = 5
	testing_library_list_tag: INTEGER = 6
	library_name_tag: INTEGER = 7

	ecf_template_string: STRING = "[
<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-15-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-15-0 http://www.eiffel.com/developers/xml/configuration-1-15-0.xsd" name="<<ECF_NAME>>" uuid="<<UUID>>" readonly="false">
	<description><<ECF_NAME>> implementation</description>
	<target name="<<ECF_NAME>>">
		<root all_classes="true"/>
		<option warning="true" void_safety="transitional" syntax="provisional">
			<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
		</option>
		<setting name="console_application" value="true"/>
<<SCOOPABLE>>
<<STANDARD_LIBRARY_LIST>>
<<GITHUB_LIBRARAY_LIST>>
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
		<root class="ANY" feature="default_create"/>
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

end
