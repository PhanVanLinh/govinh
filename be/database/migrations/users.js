require('dotenv').config();
const db = require('../db.js');

const createUsersTable = `
  CREATE TABLE IF NOT EXISTS users
  (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone VARCHAR(15) NOT NULL UNIQUE,
    score INT NULL DEFAULT 0,
    current_score INT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
`;

const migrateUsersTable = async () => {
  let connection;

  try {
    connection = await db.getConnection();

    await connection.query(createUsersTable);

    console.log('users table created!');
  } catch (err) {
    console.error('Error during migration:', err);
    process.exit(1);
  } finally {
    if (connection) connection.release();
    process.exit(0);
  }
};

migrateUsersTable();
