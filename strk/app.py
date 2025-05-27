# app.py - Main Flask Application for StockStreaks MVP
from flask import Flask, render_template, jsonify, abort
import os
import json

app = Flask(__name__)

DATA_DIR = os.path.join(os.path.dirname(__file__), 'data')
TICKERS_DIR = os.path.join(DATA_DIR, 'tickers')

def load_json_data(filename):
    """Helper to load JSON data from the data directory."""
    try:
        with open(os.path.join(DATA_DIR, filename), 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        return None # Or raise error

def load_ticker_data(symbol):
    """Helper to load JSON data for a specific ticker."""
    try:
        with open(os.path.join(TICKERS_DIR, f"{symbol.upper()}.json"), 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        return None

@app.route('/')
def home():
    market_indices = load_json_data('market_indices.json')
    notable_streaks = load_json_data('notable_streaks.json')
    if market_indices is None or notable_streaks is None:
        # Fallback or error if essential data is missing
        market_indices = []
        notable_streaks = []
    return render_template('home.html', market_indices=market_indices, notable_streaks=notable_streaks)

@app.route('/ticker/<symbol>')
def ticker_detail(symbol):
    ticker_data = load_ticker_data(symbol)
    if ticker_data is None:
        return render_template('not_found.html', symbol=symbol), 404
    return render_template('ticker_detail.html', ticker=ticker_data, symbol=symbol.upper())

# Example: A simple "Learn" page route
@app.route('/learn')
def learn():
    return render_template('learn.html') # You'll need to create learn.html

# Example: Placeholder for "Discover Streaks" page
@app.route('/discover')
def discover():
    # For MVP, this might be a simple static page or redirect to home
    return render_template('discover_streaks.html') # You'll need to create discover_streaks.html

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
