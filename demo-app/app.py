import os
import socket
from flask import Flask, jsonify

app = Flask(__name__)


def add(a, b):
    """Function from Slide 29 Lab 2."""
    return a + b


@app.route("/")
def index():
    return jsonify({
        "app": "Jenkins CI/CD Demo App",
        "status": "running",
        "hostname_or_pod": socket.gethostname(),
        "build_version": os.environ.get("BUILD_VERSION", "local-dev"),
        "sample_calculation": f"2 + 3 = {add(2, 3)}"
    })


@app.route("/health")
def health():
    return jsonify({"healthy": True}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
