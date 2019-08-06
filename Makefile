test:
	mvn package --batch-mode
	
doc:
	./documentation/bin/createDocu.sh
