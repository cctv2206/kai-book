dev:
	gitbook serve

deploy:
	gitbook build . ./docs
