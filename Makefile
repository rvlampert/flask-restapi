install-dependencies:
	@echo "--> Installing Python dependencies"
	@pip install -r requirements.txt

run:
	@echo "--> Running RestAPI"
	@python main.py

