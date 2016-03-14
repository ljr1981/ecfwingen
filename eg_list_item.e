note
	description: "[
		Representation of a {EG_LIST_ITEM}.
		]"

class
	EG_LIST_ITEM

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

			rules.extend (agent has_checked_items)
		ensure then
			rules_count: rules.count = Default_rules_capacity
		end

feature -- Access

	item: EV_CHECKABLE_LIST
			-- <Precursor>
		attribute
			create Result
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

	has_checked_items (a_item: ARRAYED_LIST [EV_LIST_ITEM]): BOOLEAN
			-- `has_checked_items'?
		do
			Result := a_item.count > 0
		end

feature {NONE} -- Implementation: Constants

	Default_rules_capacity: INTEGER = 1
			-- <Precursor>
end
