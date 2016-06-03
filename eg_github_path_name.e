note
	description: "[
		Representation of a {EG_GITHUB_PATH_NAME}.
		]"

class
	EG_GITHUB_PATH_NAME

inherit
	VA_ITEM
		redefine
			compute_post_validation_message,
			default_create,
			Default_rules_capacity,
			item
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			Precursor

			rules.extend (agent is_valid_name)
		ensure then
			rules_count: rules.count = Default_rules_capacity
		end

feature -- Access

	item: STRING
			-- <Precursor>
		attribute
			create Result.make_empty
		end

feature -- Basic Operations

	compute_post_validation_message
			-- <Precursor>
		local
			l_message: STRING
		do
			post_validation_message := Void
			create l_message.make_empty

				-- General rules messages (as-needed) ...
		ensure then
			consistent: attached post_validation_message implies not is_valid
		end

feature {NONE} -- Implementation: General Rules

	is_valid_name (a_item: like item): BOOLEAN
			-- `is_valid_name'?
		local
			l_directory: DIRECTORY
		do
			create l_directory.make_with_path (create {PATH}.make_from_string (a_item))
			Result := l_directory.exists
		end

feature {NONE} -- Implementation: Constants

	Default_rules_capacity: INTEGER = 1
			-- <Precursor>
end
