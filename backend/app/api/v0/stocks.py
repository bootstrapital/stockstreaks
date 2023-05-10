"""
Needs:
  - eventually need to be able to pull last_updated_at from db and use as the time parameter of the api lookup
    - add a pydantic model for response 
  - for now: pull rolling five years for ease/simplicity
"""

import os
import json
from datetime import datetime, timedelta

import requests

from fastapi import APIRouter
from .database import create_daily, get_streaks

router = APIRouter()


@router.get('/stocks/test', status_code=200)
def hello_world():
    return {'hello': 'world'}


@router.get('/stocks/{symbol}/prices', status_code=200)
def get_stock_prices(symbol: str):
    """Get stock prices for the last 5 years
    
    Args:
        ticker (str): Stock ticker symbol

    Returns:
        None: Returns nothing
    """

    BASE_URL = 'https://api.tiingo.com/tiingo/daily'

    today = datetime.now().date()
    five_years_ago = datetime(year=today.year - 5, month=today.month, day=today.day).date()

    # temp
    five_days_ago = today - timedelta(days=5)
    fifty_days_ago = today - timedelta(days=50)

    headers = {
        'Content-Type': 'application/json'
    }

    url_params = {
        # 'startDate': str(five_years_ago),
        'startDate': str(fifty_days_ago),
        # 'endDate': str(today),
        'endDate': str(five_days_ago),
        'token': os.getenv('TIINGO_KEY')
    }

    r = requests.get(f'{BASE_URL}/{symbol}/prices', params=url_params, headers=headers)

    if len(r.json()) > 0:
        return r.json()
    else:
        return None


@router.get('/stocks/{symbol}/calcs', status_code=200)
def calc_price_moves(symbol:str):
    dailies = get_stock_prices(symbol)

    if dailies:
        calculations = []
        for day in dailies:
            day_dt = datetime.strptime(day['date'], '%Y-%m-%dT%H:%M:%S.%fZ')
            day_performance = (day['adjClose'] / day['adjOpen']) - 1

            calculations.append({
                'symbol': symbol.lower(),
                'date_in_seconds': int(round(day_dt.timestamp())),
                'day_of_week': day_dt.weekday(),
                'close_to_open': round(day_performance, 3),
                'is_close_above_open': 1 if day_performance > 0 else 0,
            })

        ids = create_daily(calculations)

        return ids

    else:
        return {'error': 'No stock data returned'}


@router.get('/stocks/{symbol}/streaks', status_code=200)
def get_stock_streaks(symbol:str):
    """Get streaks for stock

    Args:
        symbol (str): Stock ticker symbol

    Returns:
        None: Returns nothing
    """

    streaks = get_streaks(symbol)
    return streaks
