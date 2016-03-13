note
	description: "Tests of {ECFWINGEN}."
	testing: "type/manual"

class
	ECFWINGEN_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

feature -- Test routines

	abc_tests
			-- `abc_tests'
		do
			do_nothing -- yet ...
		end

end
