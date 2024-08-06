from flask import Blueprint, send_from_directory

report_bp = Blueprint(
        'report',
        __name__, 
        url_prefix='/report', 
        static_folder='../content'
)

@report_bp.route('/')
def serve_evidence_app():
    return send_from_directory(report_bp.static_folder, 'index.html')

@report_bp.route('/<path:path>')
def serve_evidence_static(path):
    print('===================================================================')
    print(f'{report_bp.static_folder}/{path}')
    print('===================================================================')
    return send_from_directory(report_bp.static_folder, path)
