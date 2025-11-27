// backend/config/db.js
// require('dotenv').config(); ← ELIMINAR esta línea
const mongoose = require('mongoose');
const sql = require('mssql');

let sqlPool;

// ==============================
// CONEXIÓN MONGODB
// ==============================
const conectarMongo = async () => {
  try {
    if (!process.env.MONGO_URI) throw new Error("MONGO_URI no definido en .env");
    await mongoose.connect(process.env.MONGO_URI);
    console.log('✅ MongoDB conectado');
  } catch (err) {
    console.error('❌ Error conectando a MongoDB:', err.message);
    process.exit(1);
  }
};

// ==============================
// CONEXIÓN SQL SERVER
// ==============================
const conectarSQL = async () => {
  if (sqlPool) return sqlPool; // Si ya está conectado, devolverlo

  const dbConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_NAME,
    port: parseInt(process.env.DB_PORT || '1433'),
    options: {
      encrypt: false,
      trustServerCertificate: true
    }
  };

  try {
    sqlPool = await new sql.ConnectionPool(dbConfig).connect();
    console.log('✅ SQL Server conectado');
    return sqlPool;
  } catch (err) {
    console.error('❌ Error conectando a SQL Server:', err.message);
    process.exit(1);
  }
};

// ==============================
// EXPORTS
// ==============================
module.exports = {
  conectarMongo,
  conectarSQL,
  sql
};