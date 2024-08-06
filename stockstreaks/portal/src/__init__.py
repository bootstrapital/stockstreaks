from flask import Flask, send_from_directory
from .routes.auth import auth_bp
from .routes.report import report_bp
from .routes.override import ev_api_bp, ev_data_bp
from .routes.svcs import sevices_bp

def create_app():
    app = Flask(__name__)
    
    app.register_blueprint(auth_bp)
    app.register_blueprint(report_bp)
    app.register_blueprint(ev_api_bp)
    app.register_blueprint(ev_data_bp)
    app.register_blueprint(sevices_bp)

    # app.config.from_object("config")

    @app.route("/")
    def route_index():
        return 'This is the index route'
    
    @app.route("/<path:path>")
    def route_root(path):
        print('===================================================================')
        if path.endswith('.png') or path.endswith('.ico'):
            return send_from_directory('./content', path)
        else:
            return 'Nothing to see here'
    
    return app
