listen:
	FLASK_APP=gh_push_listener.py flask run

listen-pub:
	FLASK_APP=gh_push_listener.py flask run --host=0.0.0.0

setup:
	$(PYTHON) -m venv venv && source venv/bin/activate && pip install -r requirements.txt

update:
	echo "Pull project and start"