const express = require("express");
const { Pool } = require("pg");

const app = express();
const PORT = 4000;

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "heroes",
  password: "ds564",
  port: 7007,
});

app.use(express.json());

app.listen(PORT, () => {
  console.log(`funcionando normalmente ${PORT}🚀`);
});

app.get("/heros", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM heros");
    res.json(result.rows);
  } catch (err) {
    console.log(err);
  }
});
app.get("/", async (req, res) => {
    try {
        res.json({ message: "Bem-Vindo a batalha de herois." });
    } catch (err) {
        console.log(err);
    }
    });
    
app.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(`SELECT * FROM heros WHERE id =$1`, [id]);
    res.json(result.rows);
  } catch (err) {
    console.log(err);
  }
});
app.post("/heros", async (req, res) => {
  const { name, power_values, power_type, hp, attack } = req.body;
  try {
   await pool.query(
      `INSERT INTO heros (name, power_values, power_type, hp , attack ) VALUES ($1, $2,$3,$4,$5)`,
      [name, power_values, power_type, hp, attack]
    );
    res.json({ message: "Heroi cadastrado com sucesso" });
  } catch (err) {
    console.log(err);
  }
});

app.put("/:id", async (req, res) => {
  const { id } = req.params;
  const { name, power_values, power_type, hp, attack } = req.body;
  try {
    const result = await pool.query(
      `UPDATE heros SET name = $1, power_values = $2, power_type = $3, hp = $4, attack = $5 WHERE id = $6`,
      [name, power_values, power_type, hp, attack, id]
    );
    res.json(result.rows);
  } catch (err) {
    console.log(err);
  }
});