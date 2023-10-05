from fastapi import FastAPI, APIRouter
from fastapi.middleware.cors import CORSMiddleware

from api import routes

app = FastAPI(title='Ticker Moves - Backend')

origins = [
    "0.0.0.0:3000",
    "http://localhost",
    "http://localhost:3000",
    'file:///Users/chris/Documents/GitHub/stockstreaks/index.html',
    '../../index.html'
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

root_router = APIRouter()

@root_router.get('/', status_code=200)
def read_root():
    return {'Hello': 'World'}

@root_router.get('/local-test', status_code=200)
def local_test():
    return {
        'data': [{
            'name': "Some Data",
            'type': "bar",
            'values': [25, 40, 30, 35, 8, 52, 17, -4]
          },
          {
            'name': "Another Set",
            'type': "line",
            'values': [25, 50, -10, 15, 18, 32, 27, 14]
          }
        ]
    }

app.include_router(routes.api_router, prefix='/api')
app.include_router(root_router)
