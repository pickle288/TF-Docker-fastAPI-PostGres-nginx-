from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

DB_HOST = os.getenv("DATABASE_HOST")
DB_NAME = os.getenv("DATABASE_NAME")
DB_USER = os.getenv("DATABASE_USER")
DB_PASSWORD = os.getenv("DATABASE_PASSWORD")

def get_conn():
    return psycopg2.connect(
        host=DB_HOST,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )

@app.on_event("startup")
def startup():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS messages (
            id SERIAL PRIMARY KEY,
            content TEXT NOT NULL
        );
    """)
    conn.commit()
    cur.close()
    conn.close()

@app.get("/")
def root():
    return {"status": "API connected to Postgres"}

@app.post("/messages")
def add_message(msg: str):
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("INSERT INTO messages (content) VALUES (%s)", (msg,))
    conn.commit()
    cur.close()
    conn.close()
    return {"status": "inserted"}

@app.get("/messages")
def get_messages():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT id, content FROM messages")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows
