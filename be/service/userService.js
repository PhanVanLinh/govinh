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
  // score_history user_id, point
  try {
    const [result] = await db.execute(query, [phone, point, point])
    return res.status(201).json({message: 'User created', user: {id: result.insertId, phone: phone}})
  } catch (err) {
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'User already exists'})
    }
    console.error('Error creating user:', err)
    return res.status(500).json({error: 'Internal server error'})
  }
}

module.exports = {addUser}
