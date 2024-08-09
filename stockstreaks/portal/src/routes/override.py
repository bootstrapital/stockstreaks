from flask import Blueprint, redirect, send_from_directory


# ===== API files =====
ev_api_bp = Blueprint(
        'ev_api',
        __name__, 
        url_prefix='/api', 
        static_folder='../content/api'
)

@ev_api_bp.route('/<path:path>')
def serve_evidence_static(path):
    print('===================================================================')
    print(f'{ev_api_bp.static_folder}/{path}')
    print('===================================================================')

    if 'null' in path:
        print('===== Tryting to fix the null =====')
        print(f'{ev_api_bp.static_folder}')
        return send_from_directory(f'{ev_api_bp.static_folder}', 'evidencemeta.json')
    
    return send_from_directory(ev_api_bp.static_folder, path)
# ------------------------------------------------------------------------------


# ===== Data files =====
ev_data_bp = Blueprint(
        'ev_data',
        __name__, 
        url_prefix='/data', 
        static_folder='../content/data'
)

@ev_data_bp.route('/<path:path>')
def serve_evidence_data(path):
    print('===================================================================')
    print(f'{ev_data_bp.static_folder}/{path}')
    print('===================================================================')
    return send_from_directory(ev_data_bp.static_folder, path)
# ------------------------------------------------------------------------------