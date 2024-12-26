const db = require('../database/db');

const getUsersWithCodesAndRewards = async (req, res) => {
  const query = `
      SELECT
          u.id AS user_id,
          u.phone,
          (SELECT JSON_ARRAYAGG(
                          JSON_OBJECT(
                                  'code', sub_c.code,
                                  'usage_count', sub_c.usage_count
                          )
                  )
           FROM (
                    SELECT DISTINCT
                        c.code,
                        code_usage.usage_count
                    FROM user_code uc
                             JOIN codes c ON uc.code_id = c.id
                             JOIN (
                        SELECT
                            uc.user_id,
                            uc.code_id,
                            COUNT(uc.code_id) AS usage_count
                        FROM user_code uc
                        GROUP BY uc.user_id, uc.code_id
                    ) AS code_usage ON uc.code_id = code_usage.code_id
                    WHERE uc.user_id = u.id
                ) AS sub_c) AS codes,
          (SELECT JSON_ARRAYAGG(
                          JSON_OBJECT(
                                  'reward', sub_r.name,
                                  'usage_count', sub_r.usage_count
                          )
                  )
           FROM (
                    SELECT DISTINCT
                        r.name,
                        reward_usage.usage_count
                    FROM user_reward ur
                             JOIN rewards r ON ur.reward_id = r.id
                             JOIN (
                        SELECT
                            ur.user_id,
                            ur.reward_id,
                            COUNT(ur.reward_id) AS usage_count
                        FROM user_reward ur
                        GROUP BY ur.user_id, ur.reward_id
                    ) AS reward_usage ON ur.reward_id = reward_usage.reward_id
                    WHERE ur.user_id = u.id
                ) AS sub_r) AS rewards
      FROM users u;
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
