require('dotenv').config();
const db = require('../db.js');

const codesTable = `
    CREATE TABLE IF NOT EXISTS codes (
                                         id INT AUTO_INCREMENT PRIMARY KEY,
                                         code VARCHAR(255) NOT NULL UNIQUE,
        point INT NOT NULL,
        is_used BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
`;
const createUserCodeTable = `CREATE TABLE IF NOT EXISTS user_code (
                                                                      id INT AUTO_INCREMENT PRIMARY KEY,
                                                                      user_id INT NOT NULL,
                                                                      code_id INT NOT NULL,
                                                                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                                                      UNIQUE KEY unique_user_code (user_id, code_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (code_id) REFERENCES codes (id) ON DELETE CASCADE
    );
`;

const script = async () => {
  let connection;

  try {
    connection = await db.getConnection();

    await connection.query(codesTable);
    console.log('codes table created!');

    await connection.query(createUserCodeTable);
    console.log('user_code table created!');
  } catch (err) {
    console.error('Error during migration:', err);
    process.exit(1);
  } finally {
    if (connection) connection.release();
    process.exit(0);
  }
};

script();
