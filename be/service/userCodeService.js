const db = require('../database/db')

const addUserCode = async (req, res) => {
  const {user_id, code_id} = req.body

  if (!user_id || !code_id) {
    return res.status(400).json({error: 'user_id and code_id are required'})
  }

  const validateUserQuery = `SELECT id
                             FROM users
                             WHERE id = ?`
  const validateCodeQuery = `SELECT id
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

    const insertQuery = `INSERT INTO user_code (user_id, code_id)
                         VALUES (?, ?)`
    const [result] = await db.execute(insertQuery, [user_id, code_id])

    return res.status(201).json({
      message: 'User-Code relationship created',
      userCode: {id: result.insertId, user_id, code_id},
    })
  } catch (err) {
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'User-Code relationship already exists'})
    }
    return res.status(500).json({error: 'Internal server error'})
  }
}

const listUserCodes = async (req, res) => {
  const query = `SELECT *
                 FROM user_code`

  try {
    const [userCodes] = await db.execute(query)

    return res.status(200).json({
      message: 'Success',
      userCodes,
    })
  } catch (err) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

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

module.exports = {addUserCode, listUserCodes, getUserCodeById, deleteUserCode}