from flask import Flask
from flask import request
from flask_cors import CORS
from subprocess import Popen
import os

app = Flask(__name__)
CORS(app)

proc = None

def update():
	global proc
	if proc is not None:
		proc.terminate()
	cmd = ['make', 'update']
	if 'PYTHON' in os.environ:
		cmd.append('PYTHON='+os.environ['PYTHON'])

	with open('stdout.log', 'a') as out, open('stderr.log', 'a') as err:
		proc = Popen(cmd, stdout=out, stderr=err)

update()

@app.route("/", methods=['GET', 'POST'])
def on_git_push():
	if request.method == 'POST':
		if request.headers.get('X-GitHub-Event') == 'push':
			push_event = request.get_json(True)
			if push_event.get('ref') == 'refs/heads/master':
				print("Push to branch", push_event.get('ref'), "by", push_event['sender']['login'], ", updating.")
				update()
			else:
				print("Push to branch", push_event.get('ref'), "by", push_event['sender']['login'], ", not updating.")
		return "Thanks"
	else:
		return "<h1>I am listening</h1>"

@app.route("/update")
def on_update():
	update()
	return "<h1>Updated</h1>"
