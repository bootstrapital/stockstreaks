from flask import Blueprint, render_template

auth_bp = Blueprint('auth', 
                   __name__, 
                   url_prefix='/auth',
                   static_folder='../static'
            )

@auth_bp.route('/')
def auth():
    return 'This is the auth route'

# Add more API routes as needed
