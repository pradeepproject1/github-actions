from http.server import HTTPServer, BaseHTTPRequestHandler
import os

ENV = os.getenv("APP_ENV", "dev")

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(f"Hello from {ENV} environment!".encode())

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", 8080), Handler)
    print(f"Running on port 8080 - ENV: {ENV}")
    server.serve_forever()
