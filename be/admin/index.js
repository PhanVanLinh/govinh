const db = require('../database/db')
const {addCode} = require('../service/codeService')

const index = async (req, res) => {
  try {
    const shop = req.params.shop
    const usersQuery = `SELECT COUNT(*) AS userCount
                        FROM users`
    const [userResult] = await db.execute(usersQuery)
    const userCount = userResult[0].userCount

    const usedCodesQuery = `SELECT COUNT(*) AS usedCount
                            FROM codes
                            WHERE is_used = 1
                              AND shop_id = ${shop}`
    const [usedCodesResult] = await db.execute(usedCodesQuery)
    const usedCount = usedCodesResult[0].usedCount

    const unusedCodesQuery = `SELECT COUNT(*) AS unusedCount
                              FROM codes
                              WHERE is_used = 0
                                AND shop_id = ${shop}`
    const [unusedCodesResult] = await db.execute(unusedCodesQuery)
    const unusedCount = unusedCodesResult[0].unusedCount

    const rewardsQuery = `SELECT COUNT(*) AS rewardsCount
                          FROM rewards
                          where shop_id = ${shop}`
    const [rewardsResult] = await db.execute(rewardsQuery)
    const rewardsCount = rewardsResult[0].rewardsCount

    res.render('index', {
      userCount,
      usedCount,
      unusedCount,
      rewardsCount,
      shop
    })
  } catch (err) {
    console.error(err)
    res.status(500).json({error: 'Error fetching data'})
  }
}

const shops = async (req, res) => {
  try {
    const query = `SELECT *
                   FROM shops`
    const [result] = await db.execute(query)
    res.render('shops', {
      shops: result,
    })
  } catch (err) {
    console.error(err)
    res.status(500).json({error: 'Error fetching shops'})
  }
}

const getCodes = async (req, res) => {
  try {
    const query = `SELECT *
                   FROM codes
                   where shop_id = ${req.query.shop}`
    const [result] = await db.execute(query)

    const usedCount = result.filter(code => code.is_used).length
    const unusedCount = result.filter(code => !code.is_used).length

    res.render('codes', {
      codes: result,
      usedCount: usedCount,
      unusedCount: unusedCount
    })
  } catch (err) {
    console.error(err)
    res.status(500).json({error: 'error in getCodes'})
  }
}

const newCodes = async (req, res) => {
  try {
    await addCode(req.query.shop);
    res.json({ success: true, message: "Codes added successfully!" });
  } catch (e) {
    console.error(e);
    res.json({ success: false, message: "Error adding codes." });
  }
}


const getRewards = async (req, res) => {
  try {
    const query = `SELECT *
                   FROM rewards
                   where shop_id = ${req.query.shop}`
    const [result] = await db.execute(query)
    res.render('rewards', {rewards: result, shop: req.query.shop})
  } catch (err) {
    console.error(err)
    res.status(500).json({error: 'error in getRewards'})
  }
}

const getUsersWithCodesAndRewards = async (req, res) => {
  const query = `
      SELECT u.id                                      AS user_id,
             u.phone,
             u.score,
             u.current_score,
             (SELECT JSON_ARRAYAGG(
                             JSON_OBJECT(
                                     'code', sub_c.code,
                                     'usage_count', sub_c.usage_count
                             )
                     )
              FROM (SELECT DISTINCT c.code,
                                    code_usage.usage_count
                    FROM user_code uc
                             JOIN codes c ON uc.code_id = c.id
                             JOIN (SELECT uc.user_id,
                                          uc.code_id,
                                          COUNT(uc.code_id) AS usage_count
                                   FROM user_code uc
                                   GROUP BY uc.user_id, uc.code_id) AS code_usage ON uc.code_id = code_usage.code_id
                    WHERE uc.user_id = u.id) AS sub_c) AS codes,
             (SELECT JSON_ARRAYAGG(
                             JSON_OBJECT(
                                     'reward', sub_r.name,
                                     'usage_count', sub_r.usage_count
                             )
                     )
              FROM (SELECT DISTINCT r.name,
                                    reward_usage.usage_count
                    FROM user_reward ur
                             JOIN rewards r ON ur.reward_id = r.id
                             JOIN (SELECT ur.user_id,
                                          ur.reward_id,
                                          COUNT(ur.reward_id) AS usage_count
                                   FROM user_reward ur
                                   GROUP BY ur.user_id, ur.reward_id) AS reward_usage
                                  ON ur.reward_id = reward_usage.reward_id
                    WHERE ur.user_id = u.id) AS sub_r) AS rewards
      FROM users u;
  `

  try {
    const [results] = await db.query(query)
    res.render('users', {users: results})
  } catch (err) {
    console.error(err)
    res.status(500).send('Internal Server Error')
  }
}

module.exports = {getUsersWithCodesAndRewards, index, getCodes, getRewards, shops, newCodes}
