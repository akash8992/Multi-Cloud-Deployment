from fastapi import FastAPI
import os

app = FastAPI()
NODE_NAME = os.getenv("NODE_NAME", "unknown")

@app.get("/")
async def root():
    return {"message": f"Hello from {NODE_NAME}!"}

@app.get("/health")
async def health():
    return {"status": "healthy"}