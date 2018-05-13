@properties = {all: [], base: [], existing: []}

@properties[:all] << "test"
@properties[:all] << "test 2"
@properties[:existing] << "existing 1"

puts @properties.inspect
