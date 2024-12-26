require('dotenv').config()
const db = require('../db.js')

const createShopsTable = `
    CREATE TABLE IF NOT EXISTS shops
    (
        id
        INT
        AUTO_INCREMENT
        PRIMARY
        KEY,
        name
        VARCHAR
    (
        15
    ) NOT NULL UNIQUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
`

const migrateShopsTable = async () => {
  let connection

  try {
    connection = await db.getConnection()

    await connection.query(createShopsTable)

    console.log('shops table created!')
  } catch (err) {
    console.error('Error during migration:', err)
    process.exit(1)
  } finally {
    if (connection) connection.release()
    process.exit(0)
  }
}

migrateShopsTable()
