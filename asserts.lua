function assert_boolean(b)
    assert(type(b) == "boolean", "value must be a boolean")
    return b
end

function assert_number(n)
    assert(type(n) == "number", "value must be a number")
    return n
end

function assert_non_negative_number(n)
    assert_number(n)
    assert(n >= 0, "value must be a non-negative number")
    return n
end

function assert_positive_number(n)
    assert_number(n)
    assert(n > 0, "value must be a positive number")
    return n
end
