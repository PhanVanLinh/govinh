const db = require('../database/db');

const getUsersWithCodesAndRewards = async (req, res) => {
  const query = `
      SELECT
          u.id AS user_id,
          u.phone,
          JSON_ARRAYAGG(
                  JSON_OBJECT(
                          'code', c.code,
                          'usage_count', code_usage.usage_count
                  )
          ) AS codes,
          JSON_ARRAYAGG(
                  JSON_OBJECT(
                          'reward', r.name,
                          'usage_count', reward_usage.usage_count
                  )
          ) AS rewards
      FROM users u
               LEFT JOIN (
          SELECT
              uc.user_id,
              uc.code_id,
              COUNT(uc.code_id) AS usage_count
          FROM user_code uc
          GROUP BY uc.user_id, uc.code_id
      ) AS code_usage ON u.id = code_usage.user_id
               LEFT JOIN codes c ON code_usage.code_id = c.id
               LEFT JOIN (
          SELECT
              ur.user_id,
              ur.reward_id,
              COUNT(ur.reward_id) AS usage_count
          FROM user_reward ur
          GROUP BY ur.user_id, ur.reward_id
      ) AS reward_usage ON u.id = reward_usage.user_id
               LEFT JOIN rewards r ON reward_usage.reward_id = r.id
      GROUP BY u.id, u.phone;
  `;

  try {
    const [results] = await db.query(query);
    res.render('admin', { users: results });
  } catch (err) {
    console.error(err);
    res.status(500).send('Internal Server Error');
  }
};

module.exports = { getUsersWithCodesAndRewards };
