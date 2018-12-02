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
	cd ../iis/ && \
	git pull && \
	cd frontend/ && \
	npm run build && \
	cp -r build/static ../backend && \
	cp build/index.html ../backend/templates/index.html && \
	cd ../ && \
	cd backend/ && \
	(test -d venv || $(PYTHON) -m venv venv) && \
	. venv/bin/activate && \
	pip3 install -Ur requirements.txt && \
	python manage.py migrate && \
	python manage.py loaddata sample_data && \
	python manage.py runserver 0.0.0.0:8000
