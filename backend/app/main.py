from fastapi import FastAPI, APIRouter
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse 
from fastapi.middleware.cors import CORSMiddleware

from api import routes

app = FastAPI(title='Ticker Moves - Backend')

origins = [
    "0.0.0.0:3000",
    "http://localhost",
    "http://localhost:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.mount("/static", StaticFiles(directory="static", html = True), name="static")
root_router = APIRouter()

# @root_router.get('/', status_code=200)
# def read_root():
#     return {'Hello': 'World'}

@root_router.get('/', status_code=200)
async def read_index():
    return FileResponse('home.html')

app.include_router(routes.api_router, prefix='/api')
app.include_router(root_router)