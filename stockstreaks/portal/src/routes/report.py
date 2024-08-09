from flask import Blueprint, redirect, send_from_directory


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

    if path.endswith('png') or path.endswith('.ico') or path.endswith('icon.svg'):
        print('=================================================================== images')
        print(f'{report_bp.static_folder}/{path}')
        return send_from_directory(f'{report_bp.static_folder}', path)

    if path.endswith('tickers'):
        return redirect(f'/report/tickers/')

    elif path.endswith('tickers/'):
        print('=================================================================== tickers')
        print(f'{report_bp.static_folder}/{path}')
        return send_from_directory(f'{report_bp.static_folder}/{path}', 'index.html')
    
    elif 'tickers' in path:
        return send_from_directory(f'{report_bp.static_folder}/{path}', 'index.html')

    return send_from_directory(report_bp.static_folder, path)
