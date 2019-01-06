

dev:
	gitbook serve ./book

test-message:
	m = 'default message'
	echo $(m)

deploy-test:
	cp -R ~/Documents/gitbook/ ~/Dev/kai-book/book
	gitbook serve ./book

deploy-online:
	cp -R ~/Documents/gitbook/ ~/Dev/kai-book/book
	gitbook build ./book ./docs
	git add .
	git commit -m $(m)
