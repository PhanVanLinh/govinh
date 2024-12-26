const db = require('../database/db')
const {isValidPhoneNumber} = require('libphonenumber-js')

const addUser = async (req, res) => {
  let {phone, point} = req.body

  if (!phone) {
    return res.status(400).json({error: 'Phone is required'})
  }
  if (!isValidPhoneNumber(phone, 'VN')) {
    return res.status(400).json({error: 'Invalid phone number'})
  }

  if (!point) {
    point = 10
  }

  const query = `INSERT INTO users (phone, score, current_score) VALUES (?, ?, ?);`
  try {
    const [result] = await db.execute(query, [phone, point, point])
    const queryScore = `INSERT INTO scores (user_id, score)
                        VALUES (?, ?);`

    await db.execute(queryScore, [result.insertId, point])
    return res.status(201).json({
      message: 'User created',
      user: {id: result.insertId, phone: phone},
      score: {user_id: result.insertId, score: point}
    })
  } catch (err) {
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'User already exists'})
    }
    console.error('Error creating user:', err)
    return res.status(500).json({error: 'Internal server error'})
  }
}

const getUser = async (req, res) => {
  try {
    let {phone} = req.query
    if (!phone) {
      return res.status(400).json({error: 'Phone number is required'})
    }
    const query = `SELECT *
                   FROM users
                   where phone = ?;`
    const [result] = await db.execute(query, [phone])
    if (result.length <= 0) {
      return res.status(200).json({user: []})
    }
    const userId = result[0].id
    const scoreQuery = `SELECT *
                        FROM scores
                        WHERE user_id = ?;`
    const [scoreResult] = await db.execute(scoreQuery, [userId])
    return res.status(200).json({user: result[0], scores: scoreResult})
  } catch (e) {
    console.error('Error: ', e)
    return res.status(500).json({error: 'Internal server error'})
  }

}

module.exports = {addUser, getUser}
