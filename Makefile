install:
	bundle install

test:
	rake test

lint: 
	rubocop

.PHONY: test