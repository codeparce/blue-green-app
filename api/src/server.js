import "dotenv/config";
import express from "express";
import cors from "cors";
import pg from "pg";

const { Pool } = pg;
const app = express();
const port = Number(process.env.PORT || 3000);
const pool = new Pool({
    host: process.env.DB_HOST || "localhost",
    port: Number(process.env.DB_PORT || 5432),
    database: process.env.DB_NAME || "bluegreen",
    user: process.env.DB_USER || "bluegreen",
    password: process.env.DB_PASSWORD || "bluegreen"
});

app.use(cors());
app.use(express.json());

app.get("/health", async (_request, response) => {
    try {
        await pool.query("SELECT 1");
        response.json({ status: "ok", database: "connected" });
    } catch {
        response.status(503).json({ status: "error", database: "unavailable" });
    }
});

app.get("/api/items", async (_request, response) => {
    try {
        const result = await pool.query(
            "SELECT id, name, descrip, monto, created_at FROM items ORDER BY id DESC"
        );
        response.json(result.rows);
    } catch (error) {
        console.error(error);
        response.status(500).json({ error: "No se pudieron listar los datos" });
    }
});

app.post("/api/items", async (request, response) => {
    const { name, descrip, monto } = request.body;
    const amount = Number(monto);

    if (typeof name !== "string" || !name.trim() || typeof descrip !== "string" || !Number.isFinite(amount)) {
        return response.status(400).json({
            error: "Los campos name, descrip y monto son obligatorios; monto debe ser numérico"
        });
    }

    try {
        const result = await pool.query(
            "INSERT INTO items (name, descrip, monto) VALUES ($1, $2, $3) RETURNING id, name, descrip, monto, created_at",
            [name.trim(), descrip.trim(), amount]
        );
        response.status(201).json(result.rows[0]);
    } catch (error) {
        console.error(error);
        response.status(500).json({ error: "No se pudo insertar el dato" });
    }
});

app.listen(port, () => {
    console.log(`API escuchando en http://localhost:${port}`);
    console.log("Database IN : ", process.env.DB_HOST)
});
