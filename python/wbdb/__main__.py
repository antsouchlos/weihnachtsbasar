from wbdb import app
from waitress import serve

if __name__ == "__main__":
    print("[DEBUG] Running server")
    serve(app, host="0.0.0.0", port=5000)
