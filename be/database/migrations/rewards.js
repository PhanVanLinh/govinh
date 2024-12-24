require('dotenv').config();
const db = require('../db.js');

const createRewardsTable = `
    CREATE TABLE IF NOT EXISTS rewards (id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(255) NOT NULL UNIQUE, value INT NOT NULL DEFAULT 0,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );`;
const createUserRewardTable = `
    CREATE TABLE IF NOT EXISTS user_reward (id INT AUTO_INCREMENT PRIMARY KEY,
     user_id INT NOT NULL,
     reward_id INT NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (reward_id) REFERENCES rewards(id) ON DELETE CASCADE
        
        );`;

const createRewards = async () => {
  let connection;

  try {
    connection = await db.getConnection();

    await connection.query(createRewardsTable);
    console.log('rewards table created!');

    await connection.query(createUserRewardTable);
    console.log('user_reward table created!');
  } catch (err) {
    console.error('Error during migration:', err);
    process.exit(1);
  } finally {
    if (connection) connection.release();
    process.exit(0);
  }
};

createRewards();
