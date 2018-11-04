from flask import Flask
from flask import request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/", methods=['POST'])
def on_git_push():
	if request.headers.get('X-GitHub-Event') == 'push':
		print(request.form['ref'])
	return "Thanks"
