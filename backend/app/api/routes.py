from fastapi import APIRouter

from api.v0 import stocks


api_router = APIRouter()
api_router.include_router(stocks.router, prefix='/v0', tags=['stocks'])
