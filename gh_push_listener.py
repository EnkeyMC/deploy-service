from flask import Flask
from flask import request
app = Flask(__name__)

@app.route("/", methods=['POST'])
def on_git_push():
	print(request.form['ref'])
	return "Thanks"
