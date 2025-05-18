from flask import Flask, request, jsonify
import math

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to Joel's Root App!"

@app.route('/root', methods=['GET'])
def add_numbers():
    try:
        num = int(request.args.get('num', 0))
        return jsonify({"result":math.sqrt(int(num))})
    except ValueError:
        return jsonify({"error": "Invalid input. Provide a single number."}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


