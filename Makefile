SOURCES := $(shell find src -name '*')

test.html: $(SOURCES)
	elm make src/WebAudioTest.elm --output test.html
