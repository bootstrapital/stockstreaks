from flask import Blueprint, send_from_directory


# Auth routes
sevices_bp = Blueprint(
        'svcs',
        __name__, 
        url_prefix='/svcs', 
)

@sevices_bp.route('/auth/logout')
def logout():
    return 'This is the auth route'

@sevices_bp.route('/auth/kinde_callback')
def callback():
    return 'This is the auth route'