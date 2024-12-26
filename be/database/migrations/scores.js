require('dotenv').config()
const db = require('../db.js')

const createScoresTable = `
    CREATE TABLE IF NOT EXISTS scores
    (
        id
        INT
        AUTO_INCREMENT
        PRIMARY
        KEY,
        score
        VARCHAR
    (
        15
    ) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        user_id INT NOT NULL,
        FOREIGN KEY
    (
        user_id
    ) REFERENCES users
    (
        id
    ) ON DELETE CASCADE
        );
`

const migrateScoresTable = async () => {
  let connection

  try {
    connection = await db.getConnection()

    await connection.query(createScoresTable)

    console.log('scores table created!')
  } catch (err) {
    console.error('Error during migration:', err)
    process.exit(1)
  } finally {
    if (connection) connection.release()
    process.exit(0)
  }
}

migrateScoresTable()
