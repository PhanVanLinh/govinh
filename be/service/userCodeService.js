const db = require('../database/db')

const redeem = async (req, res) => {
  const {user_phone, code,shop} = req.body;
  if (!user_phone || !code || !shop) {
    return res.status(400).json({error: 'user_phone, shop and code are required'})
  }

  const validateUserQuery = `SELECT *
                             FROM users
                             WHERE phone = ?`;
  const validateCodeQuery = `SELECT *
                             FROM codes
                             WHERE code = ?`;
  const validateShopQuery = `SELECT *
                             FROM shops
                             WHERE id = ?`;

  try {
    const [userResult] = await db.execute(validateUserQuery, [user_phone])
    const [codeResult] = await db.execute(validateCodeQuery, [code])
    const [shopResult] = await db.execute(validateShopQuery, [shop])

    if (shopResult.length === 0) {
      return res.status(404).json({error: 'Shop not found'})
    }

    if (userResult.length === 0) {
      return res.status(404).json({error: 'User not found'})
    }

    if (codeResult.length === 0) {
      return res.status(404).json({error: 'Code not found'})
    }

    const user = userResult[0]
    const codeDb = codeResult[0]

    if (codeDb.is_used) {
      return res.status(409).json({error: 'Code already used'})
    }

    const insertQuery = `INSERT INTO user_code (user_id, code_id, shop_id)
                         VALUES (?, ?, ?)`
    const [result] = await db.execute(insertQuery, [user.id, codeDb.id, shop])
    const scoreQuery = `INSERT INTO scores (user_id, score)
                        VALUES (?, ?);`
    const point = codeDb.point
    await db.execute(scoreQuery, [user.id, point])
    const updateUser = `UPDATE users
                        SET score         = ?,
                            current_score = ?
                        WHERE id = ?`
    await db.execute(`UPDATE codes SET is_used = true WHERE id = ?`, [codeDb.id])
    await db.execute(updateUser, [user.score + point, user.current_score + point, user.id])
    return res.status(201).json({
      message: 'User-Code relationship created',
      userCode: {id: result.insertId, user_id: user.id, code_id: code.id},
      score: {
        user_id: user.id,
        score: point
      }
    })
  } catch (err) {
    console.error('Error creating:', err)
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'User-Code relationship already exists'})
    }
    return res.status(500).json({error: 'Internal server error'})
  }
}

const addUserCode = async (req, res) => {
  const {user_id, code_id} = req.body

  if (!user_id || !code_id) {
    return res.status(400).json({error: 'user_id and code_id are required'})
  }

  const validateUserQuery = `SELECT *
                             FROM users
                             WHERE id = ?`
  const validateCodeQuery = `SELECT *
                             FROM codes
                             WHERE id = ?`

  try {
    const [userResult] = await db.execute(validateUserQuery, [user_id])
    const [codeResult] = await db.execute(validateCodeQuery, [code_id])

    if (userResult.length === 0) {
      return res.status(404).json({error: 'User not found'})
    }

    if (codeResult.length === 0) {
      return res.status(404).json({error: 'Code not found'})
    }
    const user = userResult[0]
    const code = codeResult[0]
    const insertQuery = `INSERT INTO user_code (user_id, code_id)
                         VALUES (?, ?)`
    const [result] = await db.execute(insertQuery, [user_id, code_id])
    const scoreQuery = `INSERT INTO scores (user_id, score) VALUES (?, ?);`
    const point = code.point
    await db.execute(scoreQuery, [user_id, point])
    const updateUser = `UPDATE users
                        SET score         = ?,
                            current_score = ?
                        WHERE id = ?`
    await db.execute(updateUser, [user.score + point, user.current_score + point, user_id])
    return res.status(201).json({
      message: 'User-Code relationship created',
      userCode: {id: result.insertId, user_id, code_id},
      score: {
        user_id: user_id,
        score: point
      }
    })
  } catch (err) {
    console.error('Error creating:', err)
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'User-Code relationship already exists'})
    }
    return res.status(500).json({error: 'Internal server error'})
  }
}

const listUserCodes = async (req, res) => {
  const {phone} = req.query

  if (!phone) {
    return res.status(400).json({error: 'Phone number is required'})
  }

  try {
    const queryUser = `SELECT id
                       FROM users
                       WHERE phone = ?`
    const [users] = await db.execute(queryUser, [phone])

    if (users.length === 0) {
      return res.status(404).json({error: 'User not found'})
    }

    const userId = users[0].id

    const queryUserCodes = `SELECT *
                            FROM user_code
                            WHERE user_id = ?`
    const [userCodes] = await db.execute(queryUserCodes, [userId])

    return res.status(200).json({
      message: 'Success',
      userCodes,
    });
  } catch (err) {
    console.error(err)
    return res.status(500).json({error: 'Internal server error', details: err.message})
  }
};

const getUserCodeById = async (req, res) => {
  const {id} = req.params

  const query = `SELECT *
                 FROM user_code
                 WHERE id = ?`
  try {
    const [result] = await db.execute(query, [id])
    if (result.length === 0) {
      return res.status(404).json({error: 'User-Code relationship not found'})
    }
    return res.status(200).json({message: 'Success', userCode: result[0]})
  } catch (err) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

const deleteUserCode = async (req, res) => {
  const {id} = req.params

  const query = `DELETE
                 FROM user_code
                 WHERE id = ?`
  try {
    const [result] = await db.execute(query, [id])
    if (result.affectedRows === 0) {
      return res.status(404).json({error: 'User-Code relationship not found'})
    }
    return res.status(200).json({message: 'User-Code relationship deleted'})
  } catch (err) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

module.exports = {redeem, addUserCode, listUserCodes, getUserCodeById, deleteUserCode}