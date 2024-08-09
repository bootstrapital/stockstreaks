from flask import Flask, send_from_directory, redirect
from .routes.auth import auth_bp
from .routes.report import report_bp
from .routes.override import ev_api_bp, ev_data_bp
from .routes.svcs import sevices_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object('config')
    
    app.register_blueprint(auth_bp)
    app.register_blueprint(report_bp)
    app.register_blueprint(ev_api_bp)
    app.register_blueprint(ev_data_bp)
    app.register_blueprint(sevices_bp)

    @app.route('/')
    def route_index():
        return 'This is the index route'
    
    @app.route('/<path:path>')
    def route_root(path):
        print('===================================================================')
        if path.endswith('.png') or path.endswith('.ico') or path.endswith('.svg'):
            print('=================================================================== images from root')
            print(f'{path}')
            return redirect(f'/report/{path}')
        # elif path.endswith('icon.svg'):
        #     return redirect(f'/report/{path}')
        elif 'tickers' in path:
            return redirect(f'/report/{path}')
        else:
            return redirect(f'/report/{path}')
    return app
