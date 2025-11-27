const sql = require('mssql');

const dbConfig = {
  user: 'jussel',
  password: '1',
  server: 'localhost',
  database: "Avila's Tyre Company",
  port: 1433,
  options: { encrypt: false, trustServerCertificate: true }
};

sql.connect(dbConfig)
  .then(pool => pool.request().query('SELECT 1 AS prueba'))
  .then(result => console.log(result.recordset))
  .catch(err => console.error('Error de conexión:', err));
