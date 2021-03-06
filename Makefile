listen: venv
	. venv/bin/activate; FLASK_APP=gh_push_listener.py flask run --port=8002

listen-pub: venv
	. venv/bin/activate; FLASK_APP=gh_push_listener.py flask run --host=0.0.0.0 --port=8002 > listener.log 2> listener_error.log

venv: venv/bin/activate

venv/bin/activate: requirements.txt
	test -d venv || $(PYTHON) -m venv venv
	. venv/bin/activate; pip3 install -Ur requirements.txt
	touch venv/bin/activate

update:
	echo "Pull project and start"