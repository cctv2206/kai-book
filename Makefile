dev:
	gitbook serve ./book

deploy:
	gitbook build ./book ./docs
