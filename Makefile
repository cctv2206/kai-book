

dev:
	cp -R ~/Documents/gitbook/ ~/Dev/kai-book/book
	gitbook serve ./book

deploy-test:
	cp -R ~/Documents/gitbook/ ~/Dev/kai-book/book
	gitbook serve ./book

deploy-online:
	cp -R ~/Documents/gitbook/ ~/Dev/kai-book/book
	gitbook build ./book ./docs
	git add .
	git commit -m 'MOD: deploy book'
	git push
